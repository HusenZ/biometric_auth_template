import 'package:bio_metric_login/home_screen.dart';
import 'package:bio_metric_login/main.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String? _status = '';
  bool _supportsFaceId = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricsOnLaunch();
    _checkAvailableBiometrics();
  }

  Future<void> _checkBiometricsOnLaunch() async {
    final isDeviceSupported = await auth.isDeviceSupported();
    final canCheckBiometrics = await auth.canCheckBiometrics;

    if (isDeviceSupported && canCheckBiometrics) {
      _authenticateWithBiometrics();
    }
  }

  Future<void> _checkAvailableBiometrics() async {
    try {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      setState(() {
        _supportsFaceId = availableBiometrics.contains(BiometricType.face);
      });
    } catch (e) {
      setState(() => _status = 'Error checking biometrics: $e');
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason:
            _supportsFaceId ? 'Scan your face to login' : 'Scan your fingerprint to login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        _navigateToHome();
      } else {
        setState(() => _status = 'Biometric auth failed. Try password.');
      }
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  Future<void> _loginWithPassword() async {
    const savedPassword = '1234'; // In real app, hash + store in secure storage

    if (_passwordController.text == savedPassword) {
      await storage.write(key: 'auth_token', value: 'secure_token_xyz');
      _navigateToHome();
    } else {
      setState(() => _status = 'Incorrect password');
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _supportsFaceId
                ? const Icon(Icons.face, size: 80)
                : const Icon(Icons.fingerprint, size: 80),
            const SizedBox(height: 10),
            Text(
              _supportsFaceId
                  ? 'Use Face ID or enter your password to login.'
                  : 'Use your fingerprint or enter your password to login.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter Password (Fallback)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loginWithPassword,
              child: const Text('Login with Password'),
            ),
            const SizedBox(height: 20),
            Text(_status ?? '', style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
