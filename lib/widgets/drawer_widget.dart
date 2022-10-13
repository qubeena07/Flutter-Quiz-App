import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/widgets/change_theme_button_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                //color: Colors.blue,
                ),
            child: Center(
                child: Text(
              user!.email.toString(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                // color: Colors.white
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
            },
          ),
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
        ],
      ),
    );
  }
}
