import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';
import 'package:quiz_app/widgets/round_button.dart';

class FinalScoreContainer extends StatelessWidget {
  final int? finalScore;
  const FinalScoreContainer({Key? key, this.finalScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Congratulation!",
            style: TextStyle(
              fontSize: 45.sp,
              fontWeight: FontWeight.w400,
              // color: Colors.black
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          //display of final score coming from home screen
          Text(
            "Your total score is $finalScore",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20.h,
          ),
          //navigate to ready screen, starts game and calls saveScore function--
          RoundButton(
              title: "Try again",
              onPress: (() {
                Navigator.pushReplacementNamed(context, RoutesName.readyScreen);
                saveScore(score: finalScore!);
              })),
          SizedBox(
            height: 20.h,
          ),
          //navigate to welcome screen of app

          RoundButton(
              title: "Home Page",
              onPress: () {
                Navigator.pushReplacementNamed(
                    context, RoutesName.welcomeScreen);
                saveScore(score: finalScore!);
              }),
        ],
      ),
    );
  }

  // function to save the score into cloud firestore with repectuve email
  Future saveScore({required int score}) async {
    final useremail = await getUseremail();
    final totalScore = FirebaseFirestore.instance.collection("score").doc();

    final scoreJson = {"email": useremail, "score": finalScore};

    await totalScore.set(scoreJson);
  }
}
