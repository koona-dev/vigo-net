import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/services/auth/controller/auth_controller.dart';
import 'package:isp_app/ui/views/dashboard_view.dart';
import 'package:isp_app/ui/views/reset_password_view.dart';
import 'package:isp_app/ui/views/signin_phone_number_view.dart';

class UserInformationView extends ConsumerStatefulWidget {
  const UserInformationView({Key? key}) : super(key: key);

  static const routeName = '/user-information';

  @override
  ConsumerState<UserInformationView> createState() =>
      _UserInformationViewState();
}

class _UserInformationViewState extends ConsumerState<UserInformationView> {
  final _addressController = TextEditingController();
  final _noKtpController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _noKtpController.dispose();
    super.dispose();
  }

  bool get isValueNotEmpty =>
      _addressController.text != '' && _noKtpController.text != '';

  void _submitLogin() async {
    final result = await ref.read(authControllerProvider).loginUser(
          username: _addressController.text,
          password: _noKtpController.text,
        );

    if (result != null) {
      Navigator.of(context).pushReplacementNamed(DashboardView.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akun Anda Belum Terdaftar'),
        ),
      );
    }
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
              'Login Dengan Akun Kamu',
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
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noKtpController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: isValueNotEmpty ? _submitLogin : null,
              child: Text('Masuk'),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ResetPasswordView.routeName);
              },
              child: Text('Lupa Password?'),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SigninPhoneNumberView.routeName);
              },
              child: Text('Belum punya akun?'),
            ),
          ],
        ),
      ),
    );
  }
}
