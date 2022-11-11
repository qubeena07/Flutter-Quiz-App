import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300.w,
            height: 400.h,
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
                  height: 8.h,
                ),
                Text('An email has been sent to ${user!.email}'),
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
      // Center(
      //   child: Text('An email has been sent to ${user!.email} please verify'),
      // ),
    ));
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
    }
  }
}
