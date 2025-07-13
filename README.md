# 🔐 Flutter Biometric Login App

A simple Flutter application demonstrating secure biometric login using **Face ID**, **Fingerprint**, and a **password fallback**. Built using `local_auth` and `flutter_secure_storage`, this app ensures a smooth and secure authentication flow on both Android and iOS devices.

---

## 🚀 Setup Instructions

1. **Clone the repository**

```bash
git clone [biometric_auth_template](https://github.com/HusenZ/biometric_auth_template.git)
cd flutter-biometric-login
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

> 📱 Use a **real device** to test biometric authentication (emulators/simulators do not support biometrics).

---

## 🛠 Platform Configuration

### ✅ Android

- Set `minSdkVersion` to `23` in `android/app/build.gradle`
- Add permissions in `AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
  <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
  ```
- Change `MainActivity.kt` to extend `FlutterFragmentActivity`:
  ```kotlin
  import io.flutter.embedding.android.FlutterFragmentActivity

  class MainActivity : FlutterFragmentActivity() {}
  ```

### ✅ iOS

- Add this to `ios/Runner/Info.plist`:
  ```xml
  <key>NSFaceIDUsageDescription</key>
  <string>We use Face ID to authenticate you securely.</string>
  ```

---

## ✨ Features

- Face ID and Fingerprint login
- Password fallback option
- Secure token storage with platform-level encryption
- Biometric check on app launch
- Friendly UI with dynamic icons based on biometric type

---

## ⚠️ Limitations & Assumptions

- Password fallback is hardcoded (`1234`) — for demo purposes only.
- No backend or user registration flow included.
- Works only on real devices with biometric hardware support.
- Biometric lockout or multiple-failure handling not implemented.

---

## 👨‍💻 Developed by

**Mohammadhusen Zhare**  
[hnkcybersec.com](https://hnkcybersec.com)

---

## 📄 License

This project is created for educational and internship demonstration purposes.

