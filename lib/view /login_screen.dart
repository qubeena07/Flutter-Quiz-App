import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/resources/colors.dart';

import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/view_model/google_signIn_view_model.dart';
import 'package:quiz_app/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = true;

  //controller for textform field of email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // function to sign in with google with firebase.
  Future<void> signInWithGoogle() async {
    await AuthenticationViewModel().signInWithGoogle();
    //use of shared preference for one time login in and save of user email.
    final sp = await SharedPreferences.getInstance();
    sp.setString(userEmail, FirebaseAuth.instance.currentUser!.email!);
    sp.setBool(loginFlag, true);
    //navigtaion to welcome screen after sucess.
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, RoutesName.welcomeScreen);
    });
  }

  //dispose of value of email and password controller after use.
  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body content of login screens witn text form fields and buttons.
      body: SingleChildScrollView(
        child: Container(
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
                height: 280.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 197, 197, 197),
                        blurRadius: 4.0.r)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      "LOGIN",
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
                      child: AutofillGroup(
                        child: TextFormField(
                          controller: emailController,
                          autofillHints: const [AutofillHints.email],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: 260.w,
                      child: AutofillGroup(
                        child: TextFormField(
                          controller: passwordController,
                          autofillHints: const [AutofillHints.password],
                          onEditingComplete: () =>
                              TextInput.finishAutofillContext(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                //display of visibility of password on icon pressed
                                child: Icon(
                                    _showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black),
                              )),
                          obscureText: !!_showPassword,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    //button for login with login functionality on pressed.
                    RoundButton(title: "Login", onPress: signIn)
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              //forgot password text with navigation to forgot password screen
              GestureDetector(
                child: Text("Forgot Password ?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                        color: AppColors.kPrimaryColor)),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.forgotPasswordScreen);
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              //navigates to the register screen for new users
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style:
                      TextStyle(fontSize: 16.sp, color: AppColors.kTextColor),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, RoutesName.registerScreen);
                          },
                        text: 'Register Here',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.kPrimaryColor)),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),

              //button for login with google with sign in with google functionality on pressed.

              RoundButton(title: "Login with Google", onPress: signInWithGoogle)
            ],
          ),
        ),
      ),
    );
  }

  //function for the login with firebase using email and password
  Future signIn() async {
    try {
      FocusScope.of(context).unfocus();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      Utils.toastMessage("Login Sucessfull");
      final sp = await SharedPreferences.getInstance();
      sp.setString(userEmail, FirebaseAuth.instance.currentUser!.email!);
      sp.setBool(loginFlag, true);

      // ignore: use_build_context_synchronously
      await Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.welcomeScreen, (route) => false);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(
          "Username or Password is not correct", context);
      log(e.toString(), name: "error in login screen");
    }
  }
}
