import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  //dispose of value of email controller after use.
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      //body of the screen with single child scroll view which lets to scroll down.
      body: SingleChildScrollView(
        child: Container(
          //declare of full height and width of the screen
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //display of logo of app using container
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
                    //Text to display the name of the screen
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //text form field for the email with controller
                    SizedBox(
                      width: 260.w,
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
                      height: 18.h,
                    ),
                    // button for the to resest password with functionality of reset password
                    RoundButton(title: "Reset Password", onPress: resetPassword
                        // Navigator.pushNamed(context, RoutesName.home);
                        )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //future function for the reset of password using firebase
  Future resetPassword() async {
    try {
      //send of passsword reset email to entered email in text form field using firebase.
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      //toast message to show the success message.
      Utils.toastMessage("Password Resent Email Sent");
      //navigation to login screen when resent email is sent
      // ignore: use_build_context_synchronously
      await Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
    }
    //catch of any firebase exception if occurs and display using flush bar errror message.
    on FirebaseAuthException catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
