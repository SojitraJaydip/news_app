import 'package:get/get.dart';
import 'package:get/get_connect.dart';

class ApiProvider extends GetConnect {
  static const String _basicUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '0fbca0c865224f489bf67105abf255e6';

  static String get basicUrl => _basicUrl;

  static String get apiKey => _apiKey;

  /// get headlines
  Future<Response> getHeadlines({required String countryCodeName}) async {
    String url =
        '$_basicUrl/top-headlines?country=$countryCodeName&apiKey=$_apiKey';
    final Response response = await get(url);
    return response;
  }

  /// get business headlines
  Future<Response> getBusinessHeadlines(
      {required String countryCodeName}) async {
    String url =
        '$_basicUrl/top-headlines?country=$countryCodeName&category=business&apiKey=$_apiKey';
    final Response response = await get(url);
    return response;
  }

  /// get Popular news for search
  Future<Response> getApplePopularNewsHeadlines(
      {required String date, required String companyName}) async {
    String url =
        '$_basicUrl/everything?q=$companyName&from=$date&to=$date&sortBy=popularity&apiKey=$_apiKey';
    final Response response = await get(url);
    return response;
  }
}
