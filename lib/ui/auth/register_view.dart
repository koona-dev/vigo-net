import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/auth/auth_controller.dart';
import 'package:isp_app/ui/auth/login_view.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  static const routeName = '/register';

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _fullnameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  bool get _isValueNotEmpty =>
      _usernameController.text != '' &&
      _passwordController.text != '' &&
      _emailController.text != '' &&
      _fullnameController.text != '';

  void _submitRegister() {
    ref.read(authControllerProvider).registerUser(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          name: _fullnameController.text,
        );

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
              'Register Dengan Akun Kamu',
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
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fullnameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isValueNotEmpty ? _submitRegister : null,
              child: Text('Register Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
