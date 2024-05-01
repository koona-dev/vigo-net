import 'package:flutter/material.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/features/auth/views/login_view.dart';
import 'package:isp_app/features/auth/views/otp_view.dart';
import 'package:isp_app/features/auth/views/register_view.dart';
import 'package:isp_app/features/auth/views/reset_password_view.dart';
import 'package:isp_app/features/auth/views/signin_phone_number_view.dart';
import 'package:isp_app/features/dashboard/views/dashboard_view.dart';
import 'package:isp_app/features/profile/views/user_information_view.dart';

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
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordView(),
      );
    case DashboardView.routeName:
      return MaterialPageRoute(
        builder: (context) => const DashboardView(),
      );
    case UserInformationView.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) =>
            const ErrorView(error: 'This page doesn\'t exist'),
      );
  }
}
