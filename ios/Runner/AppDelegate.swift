import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            // Allow only specific actions
            if action == #selector(cut(_:)) ||
               action == #selector(copy(_:)) ||
               action == #selector(paste(_:)) ||
               action == #selector(selectAll(_:)) {
                return super.canPerformAction(action, withSender: sender)
            }
            // Disable everything else (including Scan Text)
            return false
        }
}
