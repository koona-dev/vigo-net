import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/authentication/presentation/auth/reset_password_view.dart';
import 'package:isp_app/features/authentication/presentation/auth/signin_phone_number_view.dart';
import 'package:isp_app/features/authentication/presentation/auth_controller.dart';
import 'package:isp_app/features/user_management/presentation/dashboard_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get isValueNotEmpty =>
      _usernameController.text != '' && _passwordController.text != '';

  void _submitLogin() async {
    final result = await ref.read(authControllerProvider).loginUser(
          username: _usernameController.text,
          password: _passwordController.text,
        );

    if (result != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        DashboardView.routeName,
        (route) => false,
      );
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
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
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
