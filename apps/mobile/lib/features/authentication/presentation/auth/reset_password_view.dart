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
  final _confirmPswController = TextEditingController();
  List<bool> _hidePsw = [true, true];

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(),
            ),
            SizedBox(height: 36),
            Text(
              'Silahkan masukkan password baru Anda',
              style: TextStyle(
                color: Color(0xFF0F1A26),
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 52),
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
                    _hidePsw.first
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePsw.first = !_hidePsw.first;
                    });
                  },
                ),
              ),
              obscureText: _hidePsw.first,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPswController,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePsw.last
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePsw.last = !_hidePsw.last;
                    });
                  },
                ),
              ),
              obscureText: _hidePsw.last,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: isValueNotEmpty ? _submitNewPassword : null,
              child: Text('GANTI PASSWORD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF8200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isValueNotEmpty =>
      _passwordController.text != '' && _confirmPswController.text != '';

  void _submitNewPassword() async {
    final result = await ref
        .read(authControllerProvider)
        .resetPassword(_passwordController.text, _confirmPswController.text);

    if (result == null) {
      Navigator.of(context).pushReplacementNamed(LoginView.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    }
  }
}
