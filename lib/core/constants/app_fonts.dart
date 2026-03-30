class AppFonts {
  AppFonts._();

  static const primary = 'Manrope';
  static const secondary = '"Gilroy-Medium"';
  static const mono = "DM Sans";
}

enum AppFontType { primary, secondary, mono }

extension AppFontTypeX on AppFontType {
  String get value {
    switch (this) {
      case AppFontType.secondary:
        return AppFonts.secondary;
      case AppFontType.mono:
        return AppFonts.mono;
      case AppFontType.primary:
        return AppFonts.primary;
    }
  }
}
