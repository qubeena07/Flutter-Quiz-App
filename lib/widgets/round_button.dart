import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/resources/colors.dart';

//reuseable button widget
// ignore: must_be_immutable
class RoundButton extends StatelessWidget {
  final String title;
  Icon? btnIcon;
  final VoidCallback onPress;
  RoundButton(
      {Key? key, required this.title, required this.onPress, this.btnIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.kPrimaryColor),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ));
  }
}
