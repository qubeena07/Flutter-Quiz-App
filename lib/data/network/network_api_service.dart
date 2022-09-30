import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return responseJson;
  }

  // @override
  // Future getPostApiResponse(String url, dynamic data) async {
  //   dynamic responseJson;
  //   try {
  //     Response response = await http
  //         .post(Uri.parse(url), body: data)
  //         .timeout(const Duration(seconds: 10));
  //     responseJson = returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException("No internet connection");
  //   }
  //   return responseJson;
  // }

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
