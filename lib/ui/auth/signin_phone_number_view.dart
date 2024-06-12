import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/auth/auth_controller.dart';

class SigninPhoneNumberView extends ConsumerStatefulWidget {
  const SigninPhoneNumberView({Key? key}) : super(key: key);

  static const routeName = '/signin-phone-number';

  @override
  ConsumerState<SigninPhoneNumberView> createState() =>
      _SigninPhoneNumberViewState();
}

class _SigninPhoneNumberViewState extends ConsumerState<SigninPhoneNumberView> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _registerPhone() {
    ref.read(authControllerProvider).signInWithPhone(
          context,
          phoneNumber: _phoneController.text,
        );
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
              'Masukan Nomor Handphone Anda',
              style: TextStyle(
                color: Color(0xFF0F1A26),
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 52),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Nomor HP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _phoneController.text.isNotEmpty ? _registerPhone : null,
              child: Text('Daftar Nomor HP'),
            ),
          ],
        ),
      ),
    );
  }
}
