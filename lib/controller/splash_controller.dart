import 'package:get/get.dart';
import 'package:news_app/view/home/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.off(const MyHomePage());
    });
    super.onReady();
  }
}
