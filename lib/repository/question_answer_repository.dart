import 'package:quiz_app/data/network/base_api_services.dart';
import 'package:quiz_app/data/network/network_api_service.dart';
import 'package:quiz_app/model/question_answer_model..dart';
import 'package:quiz_app/resources/app_url.dart';

//repository class for question answer to get response from given api
class QuestionAnswerRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  //function of type future and QuestionAnswerModel
  Future<QuestionAnswerModel> getQuestionAnswer() async {
    try {
      //value stored in response coming from api with url.
      dynamic response = await _apiServices.getApiResponse(AppUrl.baseUrl);
      // return of response in type QuestionAnswerModel
      return QuestionAnswerModel.fromJson(response);
    }
    //catch of exception if any oocurs.
    catch (e) {
      rethrow;
    }
  }
}
