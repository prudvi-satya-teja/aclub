import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Enter the OTP sent to your email.'),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add OTP verification logic
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
