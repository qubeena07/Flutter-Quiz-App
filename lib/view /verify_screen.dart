import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/view_model/notification_view_model.dart';

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
  NotificationViewModel notificationViewModel = NotificationViewModel();
  //send verification as soon as screen in run
  @override
  void initState() {
    //checks if the user is firebase authorized user
    user = auth.currentUser;
    //send email verification to the user.
    user?.sendEmailVerification();
    //checks if email is verified in time interval of 3 seconds
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

//dispose of timer for email verification
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
          Column(
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
            ],
          ),
        ],
      ),
    ));
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    //if user is verifired send toast message, notification and naivigates to login screen
    if (user!.emailVerified) {
      timer!.cancel();
      Utils.toastMessage("Your account has been verified");
      notificationViewModel.sendNotification(
          "Verified", "Your account has been verified. Please login}");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
    }
  }
}
