import 'package:flutter/material.dart';
import 'package:isp_app/backend/orders/order.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/ui/views.dart';

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
    case ProductView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ProductView(),
      );
    case OrderView.routeName:
      return MaterialPageRoute(
        builder: (context) => OrderView(),
      );
    case OrderDetailsView.routeName:
      final args = settings.arguments as Orders;

      return MaterialPageRoute(
        builder: (context) => OrderDetailsView(order: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) =>
            const ErrorView(error: 'This page doesn\'t exist'),
      );
  }
}
