import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

//class with extends the method of baseapiservices
class NetworkApiService extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      //getting the response from given api with the timeout duration 20 seconds.
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      //return of the response in return type of method.
      responseJson = returnResponse(response);
    } on SocketException {
      // handling of exception if occurs.
      throw FetchDataException("No internet connection");
    }
    // return of decoded response body coming from api.
    return responseJson;
  }

  //function with different cases and their respective returns.
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(
            "Invalid Request with code${response.statusCode.toString()}");
      case 404:
        throw UnauthorizedException(
            "Unauthorized exception request with code ${response.statusCode.toString()}");
      default:
        throw FetchDataException(
            "Error occured while communicating with server with status code${response.statusCode}");
    }
  }
}
