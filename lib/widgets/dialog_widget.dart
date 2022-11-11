import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';

class DialogWidget {
  showAlertDialog(BuildContext context) {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("LOGOUT"),
      content: const Text("Do you want to exit the App?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: const Text("Yes"),
        ),
        SizedBox(
          width: 20.w,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: const Text("No"),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
