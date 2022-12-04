import 'dart:developer';

import 'package:flutter/material.dart';

class ScoreViewModel extends ChangeNotifier {
  int totalScore = 0;
  int questionNum = 1;
//function to set score by incremnent of 2
  setTotalScore() {
    log('heolo');
    totalScore += 2;

    log(totalScore.toString(), name: "totalscore");
    notifyListeners();
  }
//function to reset total score to 0

  resetTotalScore() {
    totalScore = 0;
    notifyListeners();
  }
//function to set the question number with increase in number

  setQuestionNum() {
    questionNum++;
    notifyListeners();
  }
//function to get the question number to 1 as game ends

  getQuestionNum() {
    questionNum = 1;
    notifyListeners();
  }
}
