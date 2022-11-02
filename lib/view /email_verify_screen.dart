import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/view%20/register_screen.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';

// ignore: must_be_immutable
class EmailVerifyScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var arguments;

  EmailVerifyScreen(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //check if user is created before or not
    isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerification());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      register(
          context: context,
          email: widget.arguments['email'],
          password: widget.arguments['password'],
          confirmPassword: widget.arguments["confirmPassword"]);
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      log(user.toString(), name: "email user");
      log(widget.arguments['email'].toString(), name: "email arguments");
      await user.sendEmailVerification();
    } catch (e) {
      Utils.snackBar("Error sending email verification", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const WelcomeScreen()
      : Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 197, 197, 197),
                          blurRadius: 2.0.r)
                    ],
                    color: Colors.white,
                    // color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        "Please verify your email!",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CircularProgressIndicator()

                      // SizedBox(
                      //   width: 260.w,
                      //   child: TextFormField(
                      //     // controller: otpController,
                      //     autovalidateMode:
                      //         AutovalidateMode.onUserInteraction,
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       fillColor: Color.fromARGB(161, 222, 233, 242),
                      //       filled: true,
                      //       label: Text(
                      //         "OTP",
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w300,
                      //         ),
                      //       ),
                      //       prefixIcon:
                      //           Icon(Icons.numbers, color: Colors.black),
                      //     ),
                      //     style: const TextStyle(
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 18.h,
                      // ),
                      // RoundButton(title: "Verify Email", onPress: () {}

                      //     // Navigator.pushNamed(context, RoutesName.home);
                      //     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
