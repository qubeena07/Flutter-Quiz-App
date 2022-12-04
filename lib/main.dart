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
  //declaration of shared preference instanxce in variable
  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool(showLogin1) ?? false;
  final showHome = prefs.getBool(loginFlag) ?? false;

  //intialization of firebase
  await Firebase.initializeApp();
  runApp(
      //declaration of all the provider used in the app
      MultiProvider(
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

final navigatorKey = GlobalKey<NavigatorState>();

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
    //use of Theme view model using provider and assign to a variable
    final themeProvider = Provider.of<ThemeViewModel>(context);

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            //theme for the app
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            //initial show screen routing
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
