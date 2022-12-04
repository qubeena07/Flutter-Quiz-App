// abstract class with a a get method
abstract class BaseApiServices {
  //get method with String paramter for url for the connection with api.
  Future<dynamic> getApiResponse(String url);
}
