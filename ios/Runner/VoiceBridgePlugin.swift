import Flutter
import UIKit
import AVFoundation

public class VoiceBridgePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?

    private var audioEngine: AVAudioEngine?
    private var isCapturing = false

    private let FRAME_BYTES = 960
    private var frameBuffer = Data()

    private var debug = true

    // MARK: Plugin Register

    public static func register(with registrar: FlutterPluginRegistrar) {

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

        print("VoiceBridgePlugin registered")
    }

    // MARK: EventChannel

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        log("EventChannel listener attached")
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        log("EventChannel listener detached")
        return nil
    }

    // MARK: MethodChannel

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {

        case "startCapture":

            let args = call.arguments as? [String: Any]
            let sampleRate = args?["sampleRate"] as? Double ?? 24000
            debug = args?["debug"] as? Bool ?? true

            startCapture(sampleRate: sampleRate)
            result(nil)

        case "stopCapture":

            stopCapture()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: Start Capture

    private func startCapture(sampleRate: Double) {

        if isCapturing {
            log("Capture already running")
            return
        }

        requestMicPermission { granted in

            if !granted {
                self.log("Microphone permission denied")
                return
            }

            DispatchQueue.main.async {
                self.startAudioEngine(sampleRate: sampleRate)
            }
        }
    }

    // MARK: Start Audio Engine

    private func startAudioEngine(sampleRate: Double) {

        do {

            let session = AVAudioSession.sharedInstance()

            try session.setCategory(
                .playAndRecord,
                mode: .voiceChat,
                options: [.defaultToSpeaker, .allowBluetooth]
            )

            try session.setActive(true)

        } catch {
            log("AVAudioSession setup failed \(error)")
        }

        audioEngine = AVAudioEngine()

        guard let engine = audioEngine else {
            log("AudioEngine creation failed")
            return
        }

        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(
            onBus: 0,
            bufferSize: 480,
            format: inputFormat
        ) { [weak self] buffer, _ in

            guard let self = self else { return }

            let audioBuffer = buffer.audioBufferList.pointee.mBuffers

            guard let mData = audioBuffer.mData else { return }

            let data = Data(bytes: mData, count: Int(audioBuffer.mDataByteSize))

            self.frameBuffer.append(data)

            while self.frameBuffer.count >= self.FRAME_BYTES {

                let frame = self.frameBuffer.prefix(self.FRAME_BYTES)
                self.frameBuffer.removeFirst(self.FRAME_BYTES)

                DispatchQueue.main.async {
                    self.eventSink?(FlutterStandardTypedData(bytes: frame))
                }
            }
        }

        do {

            try engine.start()

            isCapturing = true

            log("Native capture started")

        } catch {

            log("AudioEngine start failed \(error)")
        }
    }

    // MARK: Stop Capture

    private func stopCapture() {

        guard isCapturing else { return }

        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()

        audioEngine = nil
        frameBuffer.removeAll()

        isCapturing = false

        log("Capture stopped")
    }

    // MARK: Mic Permission

    private func requestMicPermission(_ completion: @escaping (Bool) -> Void) {

        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    // MARK: Logging

    private func log(_ msg: String) {

        if debug {
            print("VoiceBridgePlugin: \(msg)")
        }
    }
}
