import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';

class ReadyScreen extends StatefulWidget {
  const ReadyScreen({Key? key}) : super(key: key);

  @override
  State<ReadyScreen> createState() => _ReadyScreenState();
}

class _ReadyScreenState extends State<ReadyScreen>
    with SingleTickerProviderStateMixin {
  //decalre of private controller for animation
  late AnimationController? _controller;

  //initially run the function and start of animation when the function is called
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    //navigation to homescreen after completion of animation
    _controller!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
      }
    });
  }

  //dispose of animation controller after use
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body contents of ready screen using lottie package for animation
      body: Center(
        child: Lottie.asset(
          "assets/ready.json",
          animate: true,
          width: 400.w,
          height: 400.h,
          fit: BoxFit.fill,
          controller: _controller,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller!
              ..duration = const Duration(seconds: 3)
              ..forward();
          },
        ),
      ),
    );
  }
}
