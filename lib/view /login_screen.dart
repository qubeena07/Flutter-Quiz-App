import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/resources/colors.dart';

import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 10.h),
              Container(
                height: 200.h,
                width: 200.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/logo.png"))),
              ),

              Container(
                width: 300.w,
                height: 260.h,
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
                      width: 250.w,
                      child: TextFormField(
                        controller: emailController,
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
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: 250.w,
                      child: TextFormField(
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(161, 222, 233, 242),
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
                      height: 18.h,
                    ),
                    RoundButton(title: "Login", onPress: signIn
                        // Navigator.pushNamed(context, RoutesName.home);
                        )
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              RichText(
                text: TextSpan(
                  text: "Don't have an account ?",
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

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Utils.toastMessage("Login Sucessfull");

      await Navigator.pushReplacementNamed(context, RoutesName.welcomeScreen);
    } on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      print(e);
    }
  }
}
