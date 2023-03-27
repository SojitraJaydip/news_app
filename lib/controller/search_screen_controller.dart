import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_headline.dart';
import 'package:news_app/service/apis.dart';

class SearchScreenController extends GetxController {
  RxBool isNewsLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  final ApiProvider _apiProvider = ApiProvider();
  RxList<Articles> newsArticles = <Articles>[].obs;

  // search news headlines
  Future<void> fetchSearchHeadline({required String searchText}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final Response data = await _apiProvider.getApplePopularNewsHeadlines(
          companyName: searchText, date: currentDate);
      newsArticles.clear();
      if (data.status.hasError) {
        jsonEncode(data.body);
        isError.value = true;
        errorMessage.value = data.statusText.toString();
      } else {
        isError.value = false;
        errorMessage.value = '';

        if (data.status.code == 200) {
          for (var resData in data.body['articles']) {
            newsArticles.add(Articles.fromJson(resData));
          }
        } else {
          isError.value = true;
          errorMessage.value = data.statusText.toString();
        }
      }
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isNewsLoading.value = false;
    }
  }
}
