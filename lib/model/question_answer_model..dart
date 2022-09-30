class QuestionAnswerModel {
  String? question;
  int? solution;

  QuestionAnswerModel({this.question, this.solution});

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        question: json['question'] as String?,
        solution: json['solution'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'question': question,
        'solution': solution,
      };
}
