import Flutter
import UIKit
import AVFoundation

class VoiceBridgePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?
    private var audioEngine: AVAudioEngine?
    private var audioConverter: AVAudioConverter?
    private var targetFormat: AVAudioFormat?
    private var isCapturing = false
    private var debug = true

    // MARK: - Register

    static func register(with registrar: FlutterPluginRegistrar) {
        let instance = VoiceBridgePlugin()

        let methodChannel = FlutterMethodChannel(
            name: "voice_bridge/methods",
            binaryMessenger: registrar.messenger()
        )

        let eventChannel = FlutterEventChannel(
            name: "voice_bridge/pcm",
            binaryMessenger: registrar.messenger()
        )

        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        eventChannel.setStreamHandler(instance)

        print("VoiceBridgePlugin: ✅ Registered")
    }

    // MARK: - EventChannel

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        log("✅ Event listener attached")
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        log("⚠️ Event listener removed")
        return nil
    }

    // MARK: - MethodChannel

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {

        case "startCapture":
            startCapture()
            result(nil)

        case "stopCapture":
            stopCapture()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Permission

    private func requestMicPermission(completion: @escaping (Bool) -> Void) {
        let session = AVAudioSession.sharedInstance()

        switch session.recordPermission {
        case .granted:
            completion(true)

        case .denied:
            completion(false)

        case .undetermined:
            session.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }

        @unknown default:
            completion(false)
        }
    }

    // MARK: - Start Capture

    private func startCapture() {

        if isCapturing { return }

        requestMicPermission { granted in
            if !granted {
                self.log("❌ Mic permission denied")
                return
            }

            do {
                try self.startAudioEngine()
            } catch {
                self.log("❌ Engine start error: \(error)")
            }
        }
    }

    // MARK: - Audio Engine Setup

    private func startAudioEngine() throws {

        let session = AVAudioSession.sharedInstance()

        // 🔥 IMPORTANT: Play + Record + Speaker
        try session.setCategory(
            .playAndRecord,
            mode: .voiceChat,
            options: [.defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP]
        )

        try session.setActive(true)

        try session.overrideOutputAudioPort(.speaker)

        log("🔊 Audio session configured")

        audioEngine = AVAudioEngine()
        guard let engine = audioEngine else { return }

        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)

        log("🎧 Input format: \(inputFormat.sampleRate) Hz, channels: \(inputFormat.channelCount)")

        // 🎯 Target format (24kHz, mono, PCM16)
        targetFormat = AVAudioFormat(
            commonFormat: .pcmFormatInt16,
            sampleRate: 24000,
            channels: 1,
            interleaved: true
        )

        guard let targetFormat = targetFormat else {
            log("❌ Failed to create target format")
            return
        }

        audioConverter = AVAudioConverter(from: inputFormat, to: targetFormat)

        inputNode.removeTap(onBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { buffer, _ in
            self.processAudioBuffer(buffer: buffer)
        }

        engine.prepare()
        try engine.start()

        isCapturing = true
        log("🎤 Capture started")
    }

    // MARK: - Process Buffer (🔥 MAIN FIX)

    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {

        guard let converter = audioConverter,
              let targetFormat = targetFormat else {
            log("❌ Converter not ready")
            return
        }

        let frameCapacity = AVAudioFrameCount(2400) // ~100ms chunk

        guard let convertedBuffer = AVAudioPCMBuffer(
            pcmFormat: targetFormat,
            frameCapacity: frameCapacity
        ) else {
            log("❌ Buffer creation failed")
            return
        }

        var error: NSError?

        let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
            outStatus.pointee = .haveData
            return buffer
        }

        converter.convert(to: convertedBuffer, error: &error, withInputFrom: inputBlock)

        if let error = error {
            log("❌ Conversion error: \(error)")
            return
        }

        guard let channelData = convertedBuffer.int16ChannelData else {
            log("❌ No Int16 data")
            return
        }

        let channel = channelData.pointee
        let frameLength = Int(convertedBuffer.frameLength)

        let data = Data(
            bytes: channel,
            count: frameLength * MemoryLayout<Int16>.size
        )

        DispatchQueue.main.async {
            self.eventSink?(FlutterStandardTypedData(bytes: data))
        }
    }

    // MARK: - Stop

    private func stopCapture() {

        if !isCapturing { return }

        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()
        audioEngine = nil

        audioConverter = nil
        targetFormat = nil

        isCapturing = false

        log("🛑 Capture stopped")
    }

    // MARK: - Log

    private func log(_ msg: String) {
        if debug {
            print("VoiceBridgePlugin: \(msg)")
        }
    }
}