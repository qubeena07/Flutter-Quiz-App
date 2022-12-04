import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboarding_contents.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final controller = PageController();
  bool isLastPage = false;

  //initially run this function when onboarding screen is called.
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  //dispose of controller
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //contents of the onboarding screen
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            //content of onboarding screen with reuseable widgets
            OnboardingContents(
              text: "Answer a quiz to improve your mind power",
              image: "assets/onboard1.png",
            ),
            OnboardingContents(
                text: "Answer the maximum number of quiz in 120 seconds",
                image: "assets/onboard2.png"),
            OnboardingContents(
                text: "Play and invite your friends on a mind battle ",
                image: "assets/onboard3.png")
          ],
        ),
      ),
      //bottom sheet of on boadring screen with ternary operator
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  backgroundColor: AppColors.kPrimaryColor,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () async {
                Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool(showLogin1, true);

                // ignore: use_build_context_synchronously
              },
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 32),
              ))
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                      child: Text(
                        "SKIP",
                        style: TextStyle(color: AppColors.kPrimaryColor),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: AppColors.kPrimaryColor),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceInOut);
                      },
                      child: Text("NEXT",
                          style: TextStyle(color: AppColors.kPrimaryColor))),
                ],
              ),
            ),
    );
  }
}
