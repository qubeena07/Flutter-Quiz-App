import 'package:quiz_app/data/network/base_api_services.dart';
import 'package:quiz_app/data/network/network_api_service.dart';
import 'package:quiz_app/model/question_answer_model..dart';
import 'package:quiz_app/resources/app_url.dart';

class QuestionAnswerRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<QuestionAnswerModel> getQuestionAnswer() async {
    try {
      dynamic response = await _apiServices.getApiResponse(AppUrl.baseUrl);

      return QuestionAnswerModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
