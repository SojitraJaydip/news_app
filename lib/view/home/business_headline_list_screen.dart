import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/custom_widgets/news_tile_widget.dart';
import 'package:news_app/models/news_headline.dart';

import '../detailPage/news_detail_screen.dart';

class BusinessHeadLineListScreen extends StatelessWidget {
  BusinessHeadLineListScreen({Key? key}) : super(key: key);
  final controller = Get.find<NewsHeadlineController>()
    ..fetchBusinessHeadline();

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
              : Column(
                  children: [
                    _offsetPopup(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.businessHeadlineModel.value
                                .businessArticles?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              controller.articles = Articles(
                                  title: controller.businessHeadlineModel.value
                                      .businessArticles![index].title,
                                  author: controller.businessHeadlineModel.value
                                      .businessArticles![index].author,
                                  source: Source(
                                    id: controller.businessHeadlineModel.value
                                        .businessArticles![index].source!.id,
                                    name: controller.businessHeadlineModel.value
                                        .businessArticles![index].source!.name,
                                  ),
                                  description: controller.businessHeadlineModel.value
                                      .businessArticles![index].description,
                                  url: controller.businessHeadlineModel.value
                                      .businessArticles![index].url,
                                  urlToImage: controller.businessHeadlineModel.value
                                      .businessArticles![index].urlToImage,
                                  publishedAt: controller.businessHeadlineModel.value
                                      .businessArticles![index].publishedAt,
                                  content: controller.businessHeadlineModel.value
                                      .businessArticles![index].content);
                              Get.to(const NewsDetailScreen());
                            },
                            child: Hero(
                              tag: controller.businessHeadlineModel.value
                                  .businessArticles![index].title!,
                              child: LocationListItem(
                                imageUrl: controller.businessHeadlineModel.value
                                        .businessArticles?[index].urlToImage ??
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                name: controller.businessHeadlineModel.value
                                        .businessArticles?[index].title ??
                                    '',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
    });
  }

  Widget _offsetPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {
              controller.selectedCountryCode.value = 'in';
              controller.fetchBusinessHeadline();
            },
            value: 1,
            child: const Text(
              "India",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              controller.selectedCountryCode.value = 'ca';
              controller.fetchBusinessHeadline();
            },
            value: 1,
            child: const Text(
              "Canada",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              controller.selectedCountryCode.value = 'us';
              controller.fetchBusinessHeadline();
            },
            value: 2,
            child: const Text(
              "America",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        icon: Obx(() {
          return Row(
            children: [
              Text(
                controller.getCountryName().value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down_sharp)
            ],
          );
        }),
        offset: const Offset(0, 50),
      );
}
