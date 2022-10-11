import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view%20/home_screen.dart';
import 'package:quiz_app/view_model/question_answer_view_model.dart';
import 'package:quiz_app/view_model/score_view_model.dart';
import 'package:quiz_app/widgets/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  HomeScreen homeScreen = const HomeScreen();

  final user = FirebaseAuth.instance.currentUser;
  QuestionAnswerViewModel questionAnswerViewModel = QuestionAnswerViewModel();
  ScoreViewModel scoreViewModel = ScoreViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150.h,
                width: 200.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/logo.png"))),
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Text(
                user!.email!.split("@").first,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.sp),
              ),
              SizedBox(
                height: 100.h,
              ),
              Text(
                "Let's start the quiz.",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              RoundButton(
                  title: "Start",
                  onPress: () {
                    // await questionAnswerViewModel.fetchQuestionAnswerListApi();
                    // log(
                    //     questionAnswerViewModel
                    //         .fetchQuestionAnswerListApi()
                    //         .toString(),
                    //     name: "log value");
                    Navigator.pushReplacementNamed(
                        context, RoutesName.homeScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
