package com.face.face

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Handler
import android.os.Looper
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.atomic.AtomicBoolean

class VoiceBridgePlugin(
    private val activity: Activity
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private var eventSink: EventChannel.EventSink? = null

    private var audioRecord: AudioRecord? = null
    private var captureThread: Thread? = null
    private val isCapturing = AtomicBoolean(false)

    private var debug: Boolean = true
    private val mainHandler = Handler(Looper.getMainLooper())

    companion object {
        private const val METHOD_CHANNEL = "voice_bridge/methods"
        private const val EVENT_CHANNEL = "voice_bridge/pcm"

        private const val CHANNEL_CONFIG = AudioFormat.CHANNEL_IN_MONO
        private const val AUDIO_ENCODING = AudioFormat.ENCODING_PCM_16BIT

        // 20ms @ 24k PCM16 mono = 480 samples = 960 bytes
        private const val FRAME_BYTES = 960
    }

    fun register(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL)
        eventChannel = EventChannel(messenger, EVENT_CHANNEL)

        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    fun dispose() {
        stopCaptureInternal()
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        log("✅ EventChannel listener attached")
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        log("⚠️ EventChannel listener detached")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startCapture" -> {
                val sampleRate = call.argument<Int>("sampleRate") ?: 24000
                debug = call.argument<Boolean>("debug") ?: true

                try {
                    startCaptureInternal(sampleRate)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("START_CAPTURE_FAILED", e.message, null)
                }
            }

            "stopCapture" -> {
                try {
                    stopCaptureInternal()
                    result.success(null)
                } catch (e: Exception) {
                    result.error("STOP_CAPTURE_FAILED", e.message, null)
                }
            }

            else -> result.notImplemented()
        }
    }

    private fun startCaptureInternal(sampleRate: Int) {
        if (isCapturing.get()) {
            log("⚠️ Capture already running")
            return
        }

        checkMicPermission()

        val minBuffer = AudioRecord.getMinBufferSize(
            sampleRate,
            CHANNEL_CONFIG,
            AUDIO_ENCODING
        )

        if (minBuffer == AudioRecord.ERROR || minBuffer == AudioRecord.ERROR_BAD_VALUE) {
            throw IllegalStateException("Invalid AudioRecord min buffer size for sampleRate=$sampleRate")
        }

        val internalBufferBytes = maxOf(minBuffer * 2, FRAME_BYTES * 10)

        configureAudioMode()

        audioRecord = AudioRecord(
            // Hybrid-safe: better than MIC, less aggressive than VOICE_COMMUNICATION
            MediaRecorder.AudioSource.VOICE_RECOGNITION,
            sampleRate,
            CHANNEL_CONFIG,
            AUDIO_ENCODING,
            internalBufferBytes
        )

        val record = audioRecord ?: throw IllegalStateException("AudioRecord init failed")

        if (record.state != AudioRecord.STATE_INITIALIZED) {
            throw IllegalStateException("AudioRecord not initialized")
        }

        record.startRecording()
        isCapturing.set(true)

        captureThread = Thread {
            val readBuffer = ByteArray(internalBufferBytes)
            val frameBuffer = ByteArray(FRAME_BYTES)
            var frameOffset = 0
            var sentFrames = 0

            log("🎤 Native capture started sampleRate=$sampleRate buffer=$internalBufferBytes source=VOICE_RECOGNITION")

            while (isCapturing.get()) {
                val read = record.read(readBuffer, 0, readBuffer.size)

                if (read <= 0) continue

                var src = 0
                var remaining = read

                while (remaining > 0 && isCapturing.get()) {
                    val need = FRAME_BYTES - frameOffset
                    val copy = minOf(need, remaining)

                    System.arraycopy(readBuffer, src, frameBuffer, frameOffset, copy)

                    src += copy
                    remaining -= copy
                    frameOffset += copy

                    if (frameOffset == FRAME_BYTES) {
                        val outFrame = frameBuffer.clone()
                        frameOffset = 0
                        sentFrames++

                        mainHandler.post {
                            eventSink?.success(outFrame)
                        }

                        if (debug && sentFrames % 50 == 0) {
                            log("📤 emitted native PCM frame #$sentFrames bytes=${outFrame.size}")
                        }
                    }
                }
            }

            log("🛑 Native capture thread exited")
        }

        captureThread?.start()
    }

    private fun stopCaptureInternal() {
        if (!isCapturing.get()) return

        isCapturing.set(false)

        try {
            captureThread?.join(500)
        } catch (_: Exception) {
        }
        captureThread = null

        try {
            audioRecord?.stop()
        } catch (_: Exception) {
        }

        try {
            audioRecord?.release()
        } catch (_: Exception) {
        }

        audioRecord = null
        resetAudioMode()

        log("✅ Native capture stopped")
    }

    private fun configureAudioMode() {
        val am = activity.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        // Hybrid-safe: keep playback on normal media route
        am.mode = AudioManager.MODE_NORMAL
        am.isSpeakerphoneOn = true
        log("🔊 Audio mode set to MODE_NORMAL, speaker ON")
    }

    private fun resetAudioMode() {
        val am = activity.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        am.mode = AudioManager.MODE_NORMAL
        am.isSpeakerphoneOn = true
        log("🔈 Audio mode reset to MODE_NORMAL")
    }

    private fun checkMicPermission() {
        val granted = ContextCompat.checkSelfPermission(
            activity,
            Manifest.permission.RECORD_AUDIO
        ) == PackageManager.PERMISSION_GRANTED

        if (!granted) {
            throw SecurityException("RECORD_AUDIO permission not granted")
        }
    }

    private fun log(msg: String) {
        if (debug) {
            println("VoiceBridgePlugin: $msg")
        }
    }
}