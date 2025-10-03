import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';
import 'package:biosensesignal_flutter_sdk/images/image_data_listener.dart';
import 'package:biosensesignal_flutter_sdk/license/license_details.dart';
import 'package:biosensesignal_flutter_sdk/session/session.dart';
import 'package:biosensesignal_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:biosensesignal_flutter_sdk/session/session_info_listener.dart';
import 'package:biosensesignal_flutter_sdk/session/user_information.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_listener.dart';

class SessionManager {
  Session? _session;

  Future<void> createSession(
    UserInformation user,
    LicenseDetails license, {
    required ImageDataListener imageListener,
    required VitalSignsListener vitalListener,
    required SessionInfoListener infoListener,
  }) async {
    await _terminate();
    try {
      _session = await FaceSessionBuilder()
          .withUserInformation(user)
          .withImageDataListener(imageListener)
          .withVitalSignsListener(vitalListener)
          .withSessionInfoListener(infoListener)
          .build(license);
    } on HealthMonitorException catch (e) {
      throw Exception("Session creation failed: ${e.code}");
    }
  }

  Future<void> start(int duration) async {
    await _session?.start(duration);
  }

  Future<void> stop() async {
    await _session?.stop();
  }

  Future<void> _terminate() async {
    await _session?.terminate();
    _session = null;
  }

  bool get isActive => _session != null;
}
