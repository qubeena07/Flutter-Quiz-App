import 'package:flutter/material.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view%20/home_screen.dart';
import 'package:quiz_app/view%20/login_screen.dart';
import 'package:quiz_app/view%20/onboarding_screen.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';
import 'package:quiz_app/widgets/final_score_container.dart';

import '../../view /register_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.onBoardingScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnboardingScreen());

      case RoutesName.registerScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());

      case RoutesName.welcomeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen());
      case RoutesName.finalScoreConatiner:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FinalScoreContainer());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
