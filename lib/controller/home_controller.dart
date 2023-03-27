import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_headline.dart';
import 'package:news_app/service/apis.dart';

import '../models/business_headline_model.dart';

class NewsHeadlineController extends GetxController {
  RxBool isNewsLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxString selectedCountryName = 'India'.obs;
  RxString selectedCountryCode = 'in'.obs;
  RxBool isError = false.obs;
  final ApiProvider _apiProvider = ApiProvider();

  Rx<NewsHeadline> newsHeadline = NewsHeadline().obs;
  Rx<BusinessHeadlineModel> businessHeadlineModel = BusinessHeadlineModel().obs;
  Articles articles = Articles();
  List<Articles> newsArticles = [];
  List<Articles> newsTeslaArticles = [];

  // fetch news headlines
  Future<void> fetchNewsHeadline({required String countryName}) async {
    try {
      if (countryName == 'in') {
        selectedCountryName.value = 'India';
      } else if (countryName == 'ca') {
        selectedCountryName.value = 'Canada';
      } else if (countryName == 'us') {
        selectedCountryName.value = 'America';
      }

      final Response data =
          await _apiProvider.getHeadlines(countryCodeName: countryName);

      if (data.status.hasError) {
        isError.value = true;
        errorMessage.value = data.statusText.toString();
      } else {
        isError.value = false;
        errorMessage.value = '';

        if (data.status.code == 200) {
          newsHeadline.value = NewsHeadline.fromJson(data.body);
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
    update();
  }

  // fetch business headlines
  Future<void> fetchBusinessHeadline() async {
    try {
      final Response data = await _apiProvider.getBusinessHeadlines(
          countryCodeName: selectedCountryCode.value);

      if (data.status.hasError) {
        jsonEncode(data.body);
        isError.value = true;
        errorMessage.value = data.statusText.toString();
      } else {
        isError.value = false;
        errorMessage.value = '';

        if (data.status.code == 200) {
          businessHeadlineModel.value =
              BusinessHeadlineModel.fromJson(data.body);
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

  // fetch apple headlines
  Future<void> fetchApplePopularHeadline({required String companyName}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final Response data = await _apiProvider.getApplePopularNewsHeadlines(
          companyName: companyName, date: currentDate);

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

  // fetch tesla headlines
  Future<void> fetchTeslaPopularHeadline({required String companyName}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final Response data = await _apiProvider.getApplePopularNewsHeadlines(
          companyName: companyName, date: currentDate);

      if (data.status.hasError) {
        jsonEncode(data.body);
        isError.value = true;
        errorMessage.value = data.statusText.toString();
      } else {
        isError.value = false;
        errorMessage.value = '';

        if (data.status.code == 200) {
          for (var resData in data.body['articles']) {
            newsTeslaArticles.add(Articles.fromJson(resData));
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

  // get country name
  RxString getCountryName() {
    if (selectedCountryCode.value == 'in') {
      selectedCountryName.value = 'India';
      return selectedCountryName;
    } else if (selectedCountryCode.value == 'ca') {
      selectedCountryName.value = 'Canada';
      return selectedCountryName;
    } else if (selectedCountryCode.value == 'us') {
      selectedCountryName.value = 'America';
      return selectedCountryName;
    }
    return 'India'.obs;
  }
}
