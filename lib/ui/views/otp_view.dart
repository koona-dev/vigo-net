import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/services/auth/controller/auth_controller.dart';
import 'package:isp_app/ui/views/register_view.dart';

class OTPView extends ConsumerStatefulWidget {
  final String verificationId;

  const OTPView({
    super.key,
    required this.verificationId,
  });

  static const routeName = '/kode-otp';

  @override
  ConsumerState<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends ConsumerState<OTPView> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifikasiKodeOtp() {
    ref.read(authControllerProvider).verifyOTP(
          verificationId: widget.verificationId,
          userOTP: _otpController.text,
        );

    Navigator.of(context).pushReplacementNamed(RegisterView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verifikasi Akun Anda',
              style: TextStyle(
                color: Color(0xFF0F1A26),
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
                height: 0.06,
              ),
            ),
            SizedBox(height: 52),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _verifikasiKodeOtp,
              child: Text('Submit Kode'),
            ),
          ],
        ),
      ),
    );
  }
}
