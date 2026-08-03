import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Wire this up to FirebaseAuth.instance.signInWithCredential / verifyPhoneNumber
/// once your Firebase project is connected (see README "Going live").
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('PrepZone', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            const Text('Testbook se bhi advanced', textAlign: TextAlign.center),
            const SizedBox(height: 40),
            const TextField(decoration: InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: const Text('Send OTP')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () {}, child: const Text('Continue with Google')),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Continue as guest'),
            ),
          ],
        ),
      ),
    );
  }
}
