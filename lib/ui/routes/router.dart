import 'package:flutter/material.dart';
import 'package:isp_app/ui/views/dashboard_view.dart';
import 'package:isp_app/ui/views/login_view.dart';
import 'package:isp_app/ui/views/otp_view.dart';
import 'package:isp_app/ui/views/register_view.dart';
import 'package:isp_app/ui/views/reset_password_view.dart';
import 'package:isp_app/ui/views/signin_phone_number_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
    case SigninPhoneNumberView.routeName:
      return MaterialPageRoute(
        builder: (context) => const SigninPhoneNumberView(),
      );
    case OTPView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final verificationId = args['verificationId'];

      return MaterialPageRoute(
        builder: (context) => OTPView(
          verificationId: verificationId,
        ),
      );
    case RegisterView.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterView(),
      );
    case DashboardView.routeName:
      return MaterialPageRoute(
        builder: (context) => const DashboardView(),
      );
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('This page doesn\'t exist')),
        ),
      );
  }
}
