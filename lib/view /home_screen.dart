import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/response/status.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/utils/routes/routes_name.dart';
import 'package:quiz_app/view_model/question_answer_view_model.dart';
import 'package:quiz_app/widgets/round_button.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuestionAnswerViewModel questionAnswerViewModel = QuestionAnswerViewModel();
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
        seconds = maxSeconds;
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    log(seconds.toString(), name: "seconds value");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutesName.login);
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: seconds == 0
          ? Container()
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.pink.shade300,
                    Colors.purple.shade300,
                    Colors.blue.shade300
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(user!.email ?? "no user"),
                    SizedBox(
                      height: 10.h,
                    ),
                    showTimer(),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundButton(
                        title: "Start",
                        onPress: () async {
                          await questionAnswerViewModel
                              .fetchQuestionAnswerListApi();
                          log(questionAnswerViewModel
                              .fetchQuestionAnswerListApi()
                              .toString());

                          startTimer();
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    ChangeNotifierProvider<QuestionAnswerViewModel>(
                      create: (BuildContext context) => questionAnswerViewModel,
                      child: Consumer<QuestionAnswerViewModel>(
                          builder: ((context, value, _) {
                        log(value.questionAnswerList?.status.toString() ?? '',
                            name: "status value");
                        switch (value.questionAnswerList?.status) {
                          case Status.loading:
                            return const CircularProgressIndicator(); //

                          case Status.error:
                            return Text(
                                value.questionAnswerList?.message.toString() ??
                                    '');
                          case Status.completed:
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(value
                                                  .questionAnswerList
                                                  ?.data!
                                                  .question
                                                  .toString() ??
                                              ""))),
                                ),
                                Wrap(
                                    children: value.displaySolution
                                        .map((e) => ListTile(
                                              tileColor: Colors.grey,
                                              selectedTileColor: Colors.green,
                                              onTap: () async {
                                                if (value.questionAnswerList
                                                        ?.data!.solution ==
                                                    e) {
                                                  Utils.snackBar(
                                                      "Correct Answer",
                                                      Colors.green,
                                                      context);
                                                  Future.delayed(const Duration(
                                                      seconds: 2));
                                                  await questionAnswerViewModel
                                                      .fetchQuestionAnswerListApi();
                                                } else {
                                                  Utils.snackBar("Wrong Answer",
                                                      Colors.red, context);
                                                }
                                              },
                                              title: Text(e.toString()),
                                            ))
                                        .toList())
                              ],
                            );
                        }
                        return Container();
                      })),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget showTime() {
    return Text(
      seconds.toString(),
      style: TextStyle(color: Colors.white, fontSize: 50.sp),
    );
  }

  Widget showTimer() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            color: Colors.green,
            value: seconds / maxSeconds,
            strokeWidth: 12,
            backgroundColor: AppColors.kBgColor,
          ),
          Center(
            child: showTime(),
          )
        ],
      ),
    );
  }
}
