import 'package:flutter/material.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/login_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/otp_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/register_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/reset_password_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/signin_phone_number_view.dart';
import 'package:vigo_net_mobile/features/catalog_product/presentation/products/product_view.dart';
import 'package:vigo_net_mobile/features/order_internet/domain/order.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/orders/order_details_view.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/orders/order_view.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/dashboard_view.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/profile/user_information_view.dart';
import 'package:vigo_net_mobile/shared/widgets/error.dart';

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
