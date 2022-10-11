import 'dart:developer';

import 'package:flutter/material.dart';

class ScoreViewModel extends ChangeNotifier {
  int totalScore = 0;
  int questionNum = 1;
  //int get totalScore => _totalScore;
  setTotalScore() {
    log('heolo');
    totalScore += 2;

    log(totalScore.toString(), name: "totalscore");
    notifyListeners();
  }

  resetTotalScore() {
    totalScore = 0;
    notifyListeners();
  }

  setQuestionNum() {
    questionNum++;
    notifyListeners();
  }

  getQuestionNum() {
    questionNum = 1;
    notifyListeners();
  }

  // static const maxSeconds = 60;
  // int seconds = maxSeconds;
  // Timer? timer;

  // startTimer() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (seconds == 0) {
  //       timer.cancel();
  //       seconds = maxSeconds;
  //       resetTotalScore();
  //       notifyListeners();
  //     } else {
  //       seconds--;
  //       notifyListeners();
  //     }
  //     notifyListeners();
  //   });
  // }
}
