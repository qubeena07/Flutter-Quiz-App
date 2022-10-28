// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/utils/routes/routes.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view_model/question_answer_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/view_model/score_view_model.dart';
import 'package:quiz_app/view_model/theme_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool(showLogin1) ?? false;
  final showHome = prefs.getBool(loginFlag) ?? false;

  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuestionAnswerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScoreViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeViewModel(),
        ),
        StreamProvider.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        )
      ],
      child: MyApp(
        showLogin: showLogin,
        showHome: showHome,
      )));
}

class MyApp extends StatelessWidget {
  final bool showLogin;
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
    required this.showLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(showHome.toString(), name: "show home value");
    final themeProvider = Provider.of<ThemeViewModel>(context);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: MyThemes.lightTheme,
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            // home:
            //      const OnboardingScreen(),
            initialRoute: (showLogin
                ? showHome
                    ? RoutesName.welcomeScreen
                    : RoutesName.loginScreen
                : RoutesName.onBoardingScreen),
            onGenerateRoute: Routes.generateRoute);
      },
    );
  }
}
