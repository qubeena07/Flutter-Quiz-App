import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view_model/google_signIn_view_model.dart';
import 'package:quiz_app/widgets/change_theme_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await AuthenticationViewModel().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //contents of drawer widget
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Center(
                child: Text(
              user!.email.toString(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            )),
          ),
          //for theme change
          Row(
            children: [
              const ChangeThemeButtonWidget(),
              SizedBox(
                width: 10.w,
              ),
              const Text(
                "Mode",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          //for home screen
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home Screen'),
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.welcomeScreen);
            },
          ),
          //for score history
          ListTile(
            leading: const Icon(Icons.score),
            title: const Text("Score History"),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.scoreHistoryScreen);
            },
          ),
          //for logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              AuthenticationViewModel().signOut();
              final sp = await SharedPreferences.getInstance();
              sp.setBool(loginFlag, false);
              log(DateTime.now().toString(), name: "LogOut Date Time");

              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
            },
          ),
        ],
      ),
    );
  }
}
