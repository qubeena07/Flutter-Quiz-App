import 'package:flutter/material.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            OnboardingContents(
              text: "Answer a quiz to improve your mind power",
              image: "assets/onboard1.png",
            ),
            OnboardingContents(
                text: "Answer each questions of the quiz in maximum 15 seconds",
                image: "assets/onboard2.png"),
            OnboardingContents(
                text: "Play and invite your friends on a mind battle ",
                image: "assets/onboard3.png")
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  primary: Colors.white,
                  backgroundColor: AppColors.kPrimaryColor,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: ()
                  // async {
                  //   StreamBuilder<User?>(
                  //       stream: FirebaseAuth.instance.authStateChanges(),
                  //       builder: (context, snapshot) {
                  //         if (snapshot.hasData) {
                  //           return const HomeScreen();

                  //         } else {
                  //           return const LoginScreen();
                  //         }
                  //       });
                  {
                Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                //final sp = await SharedPreferences.getInstance();
                //sp.setBool('showHome', true);

                // ignore: use_build_context_synchronously
              },
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 32),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                      child: const Text("SKIP")),
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
                      child: const Text("NEXT")),
                ],
              ),
            ),
    );
  }
}
