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

        log("📩 Method call: \(call.method)")

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

        log("🔐 Permission status: \(session.recordPermission.rawValue)")

        switch session.recordPermission {
        case .granted:
            log("✅ Permission already granted")
            completion(true)

        case .denied:
            log("❌ Permission denied")
            completion(false)

        case .undetermined:
            log("⏳ Requesting permission...")
            session.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    self.log("🔐 Permission result: \(granted)")
                    completion(granted)
                }
            }

        @unknown default:
            completion(false)
        }
    }

    // MARK: - Start Capture

    private func startCapture() {

        log("🚀 startCapture called")

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
                self.log("❌ Engine start error: \(error)")
            }
        }
    }

    // MARK: - Start Engine

    private func startAudioEngine() throws {

        let session = AVAudioSession.sharedInstance()

        log("🔊 Configuring audio session...")

        try session.setCategory(
            .playAndRecord,
            mode: .voiceChat,
            options: [.defaultToSpeaker,.allowBluetooth, .allowBluetoothA2DP]
        )

        try session.setActive(true)

        log("✅ Audio session active")

        // Routing
        routeAudio()

        // Debug route
        let route = session.currentRoute
        for input in route.inputs {
            log("🎤 INPUT: \(input.portType.rawValue)")
        }
        for output in route.outputs {
            log("🔊 OUTPUT: \(output.portType.rawValue)")
        }

        // Engine
        audioEngine = AVAudioEngine()
        guard let engine = audioEngine else { return }

        let inputNode = engine.inputNode
        let format = inputNode.outputFormat(forBus: 0)

        log("🎧 Input format: \(format.sampleRate) Hz, channels: \(format.channelCount)")

        inputNode.removeTap(onBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            self.log("🎧 BUFFER RECEIVED size: \(buffer.frameLength)")
            self.processAudioBuffer(buffer: buffer)
        }

        engine.prepare()
        try engine.start()

        isCapturing = true
        log("🎤 ENGINE STARTED SUCCESSFULLY")
    }

    // MARK: - Process Audio

    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {

        guard let floatData = buffer.floatChannelData else {
            log("❌ No float data")
            return
        }

        let channel = floatData.pointee
        let frameLength = Int(buffer.frameLength)

        var pcmData = Data(capacity: frameLength * 2)

        for i in 0..<frameLength {
            let sample = channel[i]
            let clamped = max(-1.0, min(1.0, sample))
            var intSample = Int16(clamped * Float(Int16.max))
            pcmData.append(Data(bytes: &intSample, count: 2))
        }

        log("📦 Sending PCM size: \(pcmData.count)")

        DispatchQueue.main.async {
            self.eventSink?(FlutterStandardTypedData(bytes: pcmData))
        }
    }

    // MARK: - Stop

    private func stopCapture() {

        log("🛑 stopCapture called")

        if !isCapturing { return }

        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()
        audioEngine = nil

        isCapturing = false

        log("🛑 Capture stopped")
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
                log("🎧 Using earphones")
            } else {
                try session.overrideOutputAudioPort(.speaker)
                log("🔊 Using speaker")
            }

            try session.setPreferredInput(nil)

        } catch {
            log("❌ Routing error: \(error)")
        }
    }

    // MARK: - Log

    private func log(_ msg: String) {
        if debug {
            print("VoiceBridgePlugin: \(msg)")
        }
    }
}
