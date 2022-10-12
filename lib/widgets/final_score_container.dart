import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/widgets/round_button.dart';

class FinalScoreContainer extends StatelessWidget {
  final int? finalScore;
  const FinalScoreContainer({Key? key, this.finalScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congratulation!",
              style: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Your total score is $finalScore",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20.h,
            ),
            RoundButton(
                title: "Try again",
                onPress: (() => Navigator.pushReplacementNamed(
                    context, RoutesName.readyScreen))),
            SizedBox(
              height: 20.h,
            ),
            RoundButton(
                title: "Home Page",
                onPress: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.welcomeScreen);
                }),
          ],
        ),
      ),
    );
  }
}
