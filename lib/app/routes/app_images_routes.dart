class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths
  final String baseImages = 'assets/images/';
  final String baseAnimation = 'assets/animation/';
  final String baseIcons = 'assets/icons/';

  // ===== images =====

  static const splashLogo = "assets/images/splash_logo.svg";
  static const homeLogo = "assets/images/home_logo.svg";
  static const playLogo = "assets/images/play_logo.svg";
  static const historyLogo = "assets/images/history_icon.svg";
  static const settingsLogo = "assets/images/settings_logo.svg";

  static const archiveLogo = "assets/images/archive_logo.svg";
  static const editLogo = "assets/images/edit_logo.svg";
  // ===== animations =====
}
