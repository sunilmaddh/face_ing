abstract class ImageValidity {
  static const int valid = 0;
  static const int invalidDeviceOrientation = 1;
  static const int invalidRoi = 2;
  @Deprecated('Use CaptureData instead; for head tilt inspect captureData.face.yaw, captureData.face.roll, and captureData.face.pitch')
  static const int tiltedHead = 3;
  @Deprecated('Use CaptureData instead; for face distance inspect captureData.device.distance')
  static const int faceTooFar = 4;
  @Deprecated('Use CaptureData instead; for lighting inspect captureData.environment.lightingUniformity')
  static const int unevenLight = 5;
  @Deprecated('Use CaptureData instead; for face centering inspect captureData.face.verticalAlignment and captureData.face.horizontalAlignment')
  static const int faceNotCentered = 6;
  @Deprecated('Use CaptureData instead; for device alignment inspect captureData.device.pitch')
  static const int deviceNotAligned = 7;
}
