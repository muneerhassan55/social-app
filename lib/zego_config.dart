// ZEGOCLOUD credentials are passed at build time, never committed:
// flutter run --dart-define=ZEGO_APP_ID=123456789 --dart-define=ZEGO_APP_SIGN=your_app_sign
const int zegoAppId = int.fromEnvironment('ZEGO_APP_ID');
const String zegoAppSign = String.fromEnvironment('ZEGO_APP_SIGN');
