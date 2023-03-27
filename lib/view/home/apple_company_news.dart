import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/home_controller.dart';

import '../../custom_widgets/news_tile_widget.dart';
import '../detailPage/news_detail_screen.dart';

class ApplePopularNewsHeadlines extends StatelessWidget {
  ApplePopularNewsHeadlines({Key? key}) : super(key: key);
  final controller = Get.find<NewsHeadlineController>()
    ..fetchApplePopularHeadline(companyName: 'apple');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isNewsLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.isError.value
              ? Center(
                  child: Text(controller.errorMessage.value),
                )
              : ListView.builder(
                  itemCount: controller.newsArticles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        controller.articles = controller.newsArticles[index];
                        Get.to(const NewsDetailScreen());
                      },
                      child: Hero(
                        tag: controller.newsArticles[index].title!,
                        child: LocationListItem(
                          imageUrl: controller.newsArticles[index].urlToImage ??
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                          name: controller.newsArticles[index].title ?? '',
                        ),
                      ),
                    );
                  },
                );
    });
  }
}
