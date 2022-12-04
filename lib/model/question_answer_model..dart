// ignore_for_file: file_names

//model fot question and answer api to get reponses from api
class QuestionAnswerModel {
  String? question;
  int? solution;

  QuestionAnswerModel({this.question, this.solution});

  //map of model fromJson to respective data type.
  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        question: json['question'] as String?,
        solution: json['solution'] as int?,
      );
  //map of model toJson to respective data type.
  Map<String, dynamic> toJson() => {
        'question': question,
        'solution': solution,
      };
}
