import 'dart:developer';

import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_app/view_model/notification_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _confirmPassword = true;
  NotificationViewModel notificationViewModel = NotificationViewModel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late EmailAuth emailAuth;

  // void sendOTP() async {
  //   EmailAuth(sessionName: "Email Verification");
  //   var response = await emailAuth.sendOtp(recipientMail: emailController.text);
  //   log(response.toString(), name: "OTP response");
  //   if (response) {
  //     Utils.flushBarErrorMessage("OTP sent to your email", context);
  //   } else {
  //     Utils.flushBarErrorMessage("Could not sent OTP to your mail", context);
  //   }
  // }
  @override
  void initState() {
    super.initState();
    notificationViewModel.initializeNotification();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 10.h),
              Container(
                height: 131.h,
                width: 150.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/logo.png"))),
              ),

              SizedBox(
                height: 10.h,
              ),

              Container(
                width: 300.w,
                height: 350.h,
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 260.w,
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && EmailValidator.validate(email)
                                  ? null
                                  : "Enter a valid email",
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color.fromARGB(161, 222, 233, 242),
                            filled: true,
                            label: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                            // suffixIcon: TextButton(
                            //     onPressed: () {},
                            //     child: const Text("Send OTP"))
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 260.w,
                        child: TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? "Enter minimum 6 characters"
                                  : null,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(161, 222, 233, 242),
                              filled: true,
                              border: InputBorder.none,
                              label: const Text(
                                "Password",
                                style: TextStyle(color: Colors.black),
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                    _showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black),
                              )),
                          obscureText: !!_showPassword,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 260.w,
                        child: TextFormField(
                          controller: confirmPassController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // ignore: unrelated_type_equality_checks
                          validator: (value1) => value1 == passwordController
                              ? "Password doesn't match"
                              : null,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(161, 222, 233, 242),
                              filled: true,
                              border: InputBorder.none,
                              label: const Text(
                                "Confirm Password",
                                style: TextStyle(color: Colors.black),
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _confirmPassword = !_confirmPassword;
                                  });
                                },
                                child: Icon(
                                    _confirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black),
                              )),
                          obscureText: !!_confirmPassword,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      RoundButton(
                          title: "Register",
                          onPress:
                              // register
                              () {
                            final isValid = formKey.currentState!.validate();
                            if (!isValid) return;

                            //  sendOTP();
                            Navigator.pushNamed(context, RoutesName.emailVerify,
                                arguments: {
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "confirmPassword": confirmPassController.text
                                });
                            log(emailController.toString(),
                                name: "email controller value");
                            notificationViewModel.sendNotification(
                                "Quick Quiz Account Registration",
                                "Your account has been registered for the app");
                            // register
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account ?",
                  style:
                      TextStyle(fontSize: 16.sp, color: AppColors.kTextColor),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, RoutesName.loginScreen);
                          },
                        text: 'Login Here',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.kPrimaryColor)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future register() async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) return;
  //   if (passwordController.text == confirmPassController.text) {
  //     try {
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //           email: emailController.text.trim(),
  //           password: passwordController.text.trim());
  //       Utils.toastMessage("Register Sucessfull");

  //       final sp = await SharedPreferences.getInstance();
  //       sp.setString(userEmail, FirebaseAuth.instance.currentUser!.email!);
  //       // ignore: use_build_context_synchronously

  //       await Navigator.pushNamedAndRemoveUntil(
  //           context, RoutesName.welcomeScreen, (route) => false);
  //     } on FirebaseAuthException catch (e) {
  //       Utils.flushBarErrorMessage(e.message!, context);
  //       // print(e);
  //     }
  //   } else {
  //     Utils.flushBarErrorMessage("Password doesn't match", context);
  //   }
  // }
}

Future register(
    {String? email,
    String? password,
    String? confirmPassword,
    required BuildContext context}) async {
  //showDialog(
  // context: context,
  // barrierDismissible: false,
  // builder: (context) => const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  if (password == confirmPassword) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      Utils.toastMessage("Register Sucessfull");

      final sp = await SharedPreferences.getInstance();
      sp.setString(userEmail, FirebaseAuth.instance.currentUser!.email!);
      // ignore: use_build_context_synchronously
      await Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.welcomeScreen, (route) => false);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.message!, context);
      // print(e);
    }
  } else {
    Utils.flushBarErrorMessage("Password doesn't match", context);
  }
  // navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
