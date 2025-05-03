import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/login_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth_controller.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  static const routeName = '/reset-password';

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submitNewPassword() {
    ref.read(authControllerProvider).resetPassword(_passwordController.text);
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
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
              'Silahkan masukkan password baru Anda',
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
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _passwordController.text.isNotEmpty
                  ? _submitNewPassword
                  : null,
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
