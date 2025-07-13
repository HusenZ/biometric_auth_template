import 'package:bio_metric_login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

final storage = FlutterSecureStorage();
final auth = LocalAuthentication();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Auth Demo',
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
