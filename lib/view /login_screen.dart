import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/resources/colors.dart';

import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                height: 260.h,
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
                      width: 250.w,
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
                      width: 250.w,
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
                      height: 18.h,
                    ),
                    RoundButton(title: "Login", onPress: signIn
                        // Navigator.pushNamed(context, RoutesName.home);
                        )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

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
      Utils.flushBarErrorMessage(e.toString(), context);
      // print(e);
    }
  }
}
