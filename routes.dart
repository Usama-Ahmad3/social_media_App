import 'package:flutter/material.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/view/dashboard/dashboard.dart';
import 'package:social_media/view/forgot_password/forgot_password.dart';
import 'package:social_media/view/login/login_screen.dart';
import 'package:social_media/view/signup/sign_up_screen.dart';

import '../../view/splash/splash_screen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.forgetpasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
