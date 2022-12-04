import 'package:flutter/material.dart';
import 'package:quiz_app/data/response/api_response.dart';
import 'package:quiz_app/model/question_answer_model..dart';
import 'package:quiz_app/repository/question_answer_repository.dart';
import 'dart:math' as math;

//view model class which extends change notifier to listen the states
class QuestionAnswerViewModel with ChangeNotifier {
  //declare of auto genrate int value to list.
  List<int> optionSolution = List<int>.generate(10, (index) => index + 1);
  List<int> displaySolution = [];
  final random = math.Random();
  //object of class question answer repository
  final _myRepo = QuestionAnswerRepository();

  ApiResponse<QuestionAnswerModel>? questionAnswerList;

  //function to get the question question and changes of question.
  setQuestionAnswerList(ApiResponse<QuestionAnswerModel> response) {
    questionAnswerList = response;
    notifyListeners();
  }

  //Future function to  get the question from api call and solution to respective list of soluion
  Future<void> fetchQuestionAnswerListApi() async {
    setQuestionAnswerList(ApiResponse.loading());

    _myRepo.getQuestionAnswer().then((value) {
      setQuestionAnswerList(ApiResponse.completed(value));
      addSolutionToList();
    }).onError((error, stackTrace) {
      setQuestionAnswerList(ApiResponse.error(error.toString()));
    });
  }

  //void function to clear initial solution and add random int solution to teh declare list.
  void addSolutionToList() {
    displaySolution.clear();
    displaySolution.add(questionAnswerList?.data?.solution ?? 0);
    //loop for the length of solution and addition of random value to list of solution.
    while (displaySolution.length != 4) {
      var randomNumber = random.nextInt(optionSolution.length);
      if (!displaySolution.contains(randomNumber)) {
        displaySolution.add(randomNumber);
      }
    }
    displaySolution.shuffle();
  }
}
