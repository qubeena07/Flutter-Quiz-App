import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/response/status.dart';
import 'package:quiz_app/resources/colors.dart';
import 'package:quiz_app/view_model/notification_view_model.dart';
import 'package:quiz_app/view_model/question_answer_view_model.dart';
import 'package:quiz_app/view_model/score_view_model.dart';
import 'package:quiz_app/widgets/drawer_widget.dart';

import '../widgets/final_score_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScoreViewModel scoreViewModel = ScoreViewModel();
  NotificationViewModel notificationViewModel = NotificationViewModel();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuestionAnswerViewModel questionAnswerViewModel = QuestionAnswerViewModel();
  static const maxSeconds = 120;
  int wrongAnswerCount = 0;
  int seconds = maxSeconds;
  Timer? timer;
  int solutionIndicator = -1;
  List<String> indexList = ['a)', 'b)', 'c)', 'd)'];

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();

        seconds = maxSeconds;
        notificationViewModel.sendNotification(
            "Congratulations", "Your score is ${scoreViewModel.totalScore}");
        log(scoreViewModel.totalScore.toString(), name: "Total Score");
        scoreViewModel.resetTotalScore();
        scoreViewModel.setQuestionNum();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void initState() {
    _displayQuestion();
    startTimer();
    super.initState();
    notificationViewModel.initializeNotification();
  }

//private function to display question using view model
  _displayQuestion() async {
    await questionAnswerViewModel.fetchQuestionAnswerListApi();
  }

  @override
  Widget build(BuildContext context) {
    // log(seconds.toString(), name: "seconds value");
    return Scaffold(
      key: scaffoldKey,
      appBar: (seconds == 0)
          ? null
          : AppBar(
              leading: IconButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  icon: const Icon(
                    Icons.settings,
                  )),
              elevation: 0.0,
              title: (seconds == 0) ? null : showTimer(),
              centerTitle: true,
              actions: (seconds == 0)
                  ? null
                  : [
                      GestureDetector(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Quit",
                                style: TextStyle(
                                    //color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              seconds = 0;
                            });
                            notificationViewModel.sendNotification(
                                "Congratulations",
                                "Your score is ${scoreViewModel.totalScore}");
                          })

                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                      //       FirebaseAuth.instance.signOut();
                      //     },
                      //     icon: const Icon(
                      //       Icons.logout,
                      //       color: Colors.black,
                      //     )),
                    ],
              backgroundColor: (seconds == 0) ? null : AppColors.kPrimaryColor,
            ),
      drawer: const DrawerWidget(),
      body: seconds == 0
          ? FinalScoreContainer(
              finalScore: scoreViewModel.totalScore,
            )
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  //color: Color.fromARGB(255, 236, 236, 236)
                  ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Question: ${scoreViewModel.questionNum}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18.sp),
                        ),
                        const Spacer(),
                        Text(
                          "Total Score: ${scoreViewModel.totalScore}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
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
                                SizedBox(
                                  height: 10.h,
                                ),
                                Wrap(
                                    children: value.displaySolution
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),

                                                // color: Colors.yellow,
                                                child: ListTile(
                                                  trailing: Visibility(
                                                      visible:
                                                          (solutionIndicator ==
                                                              value
                                                                  .displaySolution
                                                                  .indexOf(e)),
                                                      child: (value
                                                                  .questionAnswerList
                                                                  ?.data!
                                                                  .solution ==
                                                              e)
                                                          ? Icon(
                                                              Icons.check,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  9,
                                                                  153,
                                                                  83),
                                                              size: 40.sp,
                                                            )
                                                          : Icon(Icons.close,
                                                              color: Colors.red,
                                                              size: 40.sp)),
                                                  leading: Text(
                                                    indexList[value
                                                        .displaySolution
                                                        .indexOf(e)],
                                                    style: TextStyle(
                                                        // color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15.sp),
                                                  ),
                                                  onTap: () async {
                                                    setState(() {
                                                      solutionIndicator = value
                                                          .displaySolution
                                                          .indexOf(e);
                                                    });
                                                    if (wrongAnswerCount <= 2) {
                                                      if (value
                                                              .questionAnswerList
                                                              ?.data!
                                                              .solution ==
                                                          e) {
                                                        scoreViewModel
                                                            .setTotalScore();
                                                        scoreViewModel
                                                            .setQuestionNum();
                                                        Future.delayed(
                                                          const Duration(
                                                              seconds: 1),
                                                          () async {
                                                            await questionAnswerViewModel
                                                                .fetchQuestionAnswerListApi();
                                                            setState(() {
                                                              solutionIndicator =
                                                                  -1;
                                                            });
                                                          },
                                                        );
                                                      } else {
                                                        Future.delayed(
                                                          const Duration(
                                                              seconds: 1),
                                                          () async {
                                                            await questionAnswerViewModel
                                                                .fetchQuestionAnswerListApi();
                                                            setState(() {
                                                              solutionIndicator =
                                                                  -1;
                                                            });
                                                            wrongAnswerCount++;
                                                          },
                                                        );

                                                        scoreViewModel
                                                            .setQuestionNum();
                                                      }
                                                    } else {
                                                      setState(() {
                                                        seconds = 0;
                                                        wrongAnswerCount = 0;
                                                      });
                                                    }
                                                  },
                                                  title: Text(
                                                    e.toString(),
                                                    style: TextStyle(
                                                        //color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20.sp),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList())
                              ],
                            );
                          default:
                            Container();
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
    return FittedBox(
      child: Text(
        seconds.toString(),
        style: TextStyle(
            //color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget showTimer() {
    return SizedBox(
      height: 45,
      width: 45,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
            value: seconds / maxSeconds,
            strokeWidth: 4,
            //backgroundColor: AppColors.kBgColor,
          ),
          Center(
            child: showTime(),
          )
        ],
      ),
    );
  }
}
