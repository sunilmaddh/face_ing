import Flutter
import UIKit
import AVFoundation

class VoiceBridgePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?
    private var audioEngine: AVAudioEngine?
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

        if isCapturing {
            log("⚠️ Already capturing")
            return
        }

        requestMicPermission { granted in
            if !granted {
                self.log("❌ Permission denied")
                return
            }

            do {
                try self.startAudioEngine()
            } catch {
                self.log("❌ Error: \(error)")
            }
        }
    }

    // MARK: - Start Engine

    // MARK: - Start Engine

    private func startAudioEngine() throws {

        let session = AVAudioSession.sharedInstance()

        try session.setCategory(
            .playAndRecord,
            mode: .voiceChat,
            options: [.allowBluetooth, .defaultToSpeaker]
        )

        try session.setActive(true)

        routeAudio()

        audioEngine = AVAudioEngine()

        guard let engine = audioEngine else { return }

        let inputNode = engine.inputNode

        // IMPORTANT: Always use the hardware format
        let inputFormat = inputNode.outputFormat(forBus: 0)

        print("========== INPUT FORMAT ==========")
        print("Sample Rate : \(inputFormat.sampleRate)")
        print("Channels    : \(inputFormat.channelCount)")
        print("Common      : \(inputFormat.commonFormat)")
        print("Interleaved : \(inputFormat.isInterleaved)")
        print("==================================")

        inputNode.removeTap(onBus: 0)

        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: inputFormat
        ) { [weak self] buffer, _ in

            self?.processAudioBuffer(buffer: buffer)
        }

        engine.prepare()
        try engine.start()

        isCapturing = true
        log("🎤 ENGINE STARTED")
    }

    // MARK: - Process Audio

    // MARK: - Process Audio

    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {

        guard let floatData = buffer.floatChannelData else {
            log("❌ floatChannelData is nil")
            return
        }

        let frameLength = Int(buffer.frameLength)
        let channelData = floatData.pointee

        var pcm16 = [Int16]()
        pcm16.reserveCapacity(frameLength)

        for i in 0..<frameLength {

            let sample = max(-1.0, min(1.0, channelData[i]))
            let intSample = Int16(sample * Float(Int16.max))
            pcm16.append(intSample)
        }

        let data = pcm16.withUnsafeBufferPointer {
            Data(buffer: $0)
        }

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

        isCapturing = false
        log("🛑 Stopped")
    }

    // MARK: - Routing

    private func routeAudio() {

        let session = AVAudioSession.sharedInstance()

        let hasHeadphones = session.currentRoute.outputs.contains {
            $0.portType == .headphones ||
            $0.portType == .bluetoothA2DP ||
            $0.portType == .bluetoothHFP
        }

        do {
            if hasHeadphones {
                log("🎧 Earphones connected")
            } else {
                try session.overrideOutputAudioPort(.speaker)
                log("🔊 Speaker enabled")
            }

            // ✅ important for echo
            try session.setPreferredInput(nil)

        } catch {
            log("❌ Routing error")
        }
    }

    // MARK: - Log

    private func log(_ msg: String) {
        if debug {
            print("VoiceBridgePlugin: \(msg)")
        }
    }
}
