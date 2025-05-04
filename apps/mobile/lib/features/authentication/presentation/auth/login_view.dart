import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/reset_password_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/signin_phone_number_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth_controller.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/dashboard_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePsw = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://drive.google.com/uc?export=view&id=18PBo24BHfSF5pgG6tFTRVZ58cZ7tDNjh',
              fit: BoxFit.contain,
            ),
            SizedBox(height: 36),
            Text(
              'Login Dengan Akun Kamu',
              style: TextStyle(
                color: Color(0xFF0F1A26),
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Hello, Selamat datang kembali 👋🏽',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontFamily: 'SF Pro Text',
              ),
            ),
            SizedBox(height: 52),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePsw
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePsw = !_hidePsw;
                    });
                  },
                ),
              ),
              obscureText: _hidePsw,
              keyboardType: TextInputType.visiblePassword,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ResetPasswordView.routeName);
                },
                child: Text(
                  'Lupa username/password ?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: isValueNotEmpty ? _submitLogin : null,
              child: Text('MASUK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF8200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontFamily: 'SF Pro Text',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, SigninPhoneNumberView.routeName);
                  },
                  child: Text(
                    'Pasang wifi baru',
                    style: TextStyle(
                      color: Color(0xFFEF8200),
                      fontSize: 14,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
