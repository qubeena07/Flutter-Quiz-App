import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utils/routes/routes.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view%20/onboarding_screen.dart';
import 'package:quiz_app/view_model/question_answer_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/view_model/score_view_model.dart';
import 'package:quiz_app/view_model/theme_view_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => QuestionAnswerViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ScoreViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            home: const OnboardingScreen(),
            initialRoute: RoutesName.onBoardingScreen,
            onGenerateRoute: Routes.generateRoute);
      },
    );
  }
}
