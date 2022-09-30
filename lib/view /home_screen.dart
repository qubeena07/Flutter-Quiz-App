import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/widgets/round_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
        seconds = maxSeconds;
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log(seconds.toString(), name: "seconds value");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.pink.shade300,
              Colors.purple.shade300,
              Colors.blue.shade300
            ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              showTimer(),
              SizedBox(
                height: 10.h,
              ),
              RoundButton(
                  title: "Start",
                  onPress: () {
                    startTimer();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget showTime() {
    return Text(
      seconds.toString(),
      style: TextStyle(color: Colors.white, fontSize: 50.sp),
    );
  }

  Widget showTimer() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            color: Colors.green,
            value: seconds / maxSeconds,
            strokeWidth: 12,
            backgroundColor: AppColors.kBgColor,
          ),
          Center(
            child: showTime(),
          )
        ],
      ),
    );
  }
}
