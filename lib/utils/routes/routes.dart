import 'package:flutter/material.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view%20/forgot_password_screen.dart';
import 'package:quiz_app/view%20/home_screen.dart';
import 'package:quiz_app/view%20/login_screen.dart';
import 'package:quiz_app/view%20/onboarding_screen.dart';
import 'package:quiz_app/view%20/ready_screen.dart';
import 'package:quiz_app/view%20/score_history_screen.dart';
import 'package:quiz_app/view%20/verify_screen.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';
import 'package:quiz_app/widgets/final_score_container.dart';

import '../../view /register_screen.dart';

//route class for the all the navigation between the screens.
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //routing using the name parameters
    switch (settings.name) {
      //navigation to homescreen.
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      //navigation to login screen
      case RoutesName.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      //navigation to onboarding screen
      case RoutesName.onBoardingScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnboardingScreen());

      // navigation to register screen
      case RoutesName.registerScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());
      //navigation to welcome screen
      case RoutesName.welcomeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen());
      //navigation to final score container screen
      case RoutesName.finalScoreConatiner:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FinalScoreContainer());

      //navigation to ready screen
      case RoutesName.readyScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ReadyScreen());

      //navigation to forgot password screen
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());

      //navigation to score history screen
      case RoutesName.scoreHistoryScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ScoreHistoryScreen());
      //navigation to email verification screen
      case RoutesName.verifyEmailScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const VerifyScreen());
      //incase of no route, navigation to no route defined screen.
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
