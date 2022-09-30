import 'package:flutter/material.dart';
import 'package:quiz_app/data/response/api_response.dart';
import 'package:quiz_app/model/question_answer_model..dart';
import 'package:quiz_app/repository/question_answer_repository.dart';
import 'dart:math' as math;

class QuestionAnswerViewModel with ChangeNotifier {
  List<int> optionSolution = List<int>.generate(10, (index) => index + 1);
  List<int> displaySolution = [];
  final random = math.Random();
  final _myRepo = QuestionAnswerRepository();

  ApiResponse<QuestionAnswerModel>? questionAnswerList;

  setQuestionAnswerList(ApiResponse<QuestionAnswerModel> response) {
    questionAnswerList = response;
    notifyListeners();
  }

  Future<void> fetchQuestionAnswerListApi() async {
    setQuestionAnswerList(ApiResponse.loading());

    _myRepo.getQuestionAnswer().then((value) {
      setQuestionAnswerList(ApiResponse.completed(value));
      addSolutionToList();
    }).onError((error, stackTrace) {
      setQuestionAnswerList(ApiResponse.error(error.toString()));
    });
  }

  void addSolutionToList() {
    displaySolution.clear();
    displaySolution.add(questionAnswerList?.data?.solution ?? 0);

    while (displaySolution.length != 4) {
      var randomNumber = random.nextInt(optionSolution.length);
      if (!displaySolution.contains(randomNumber)) {
        displaySolution.add(randomNumber);
      }
    }
    displaySolution.shuffle();
  }
}
