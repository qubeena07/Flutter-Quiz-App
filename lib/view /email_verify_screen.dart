import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/view%20/welcome_screen.dart';

// ignore: must_be_immutable
class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  dynamic args;
  bool isEmailVerified = false;
  Timer? timer;

  // @override
  // void initState() {
  //   super.initState();

  //   //check if user is created before or not
  //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  //   if (!isEmailVerified) {
  //     sendVerificationEmail();
  //     timer = Timer.periodic(
  //         const Duration(seconds: 3), (_) => checkEmailVerification());
  //   }
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  // Future checkEmailVerification() async {
  //   await FirebaseAuth.instance.currentUser!.reload();
  //   setState(() {
  //     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  //     register(
  //         context: context,
  //         email: args["email"],
  //         password: args["password"],
  //         confirmPassword: args["confirmPassword"]);
  //   });
  //   if (isEmailVerified) timer?.cancel();
  // }

  // Future sendVerificationEmail() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser!;
  //     log(user.toString(), name: "email user");
  //     await user.sendEmailVerification();
  //   } catch (e) {
  //     Utils.snackBar("Error sending email verification", Colors.red, context);
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments;
    log(args["email"].toString(), name: "args value");
    setState(() {});
  }

  // Future<bool> verifyOTP() async {
  //   var response = emailAuth.validateOtp(
  //       recipientMail: args["email"], userOtp: otpController.text);
  //   if (response) {
  //     Utils.flushBarErrorMessage("OTP Verified", context);
  //     return true;
  //   } else {
  //     Utils.flushBarErrorMessage("Invalid OTP", context);
  //     return false;
  //   }
  // }

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
