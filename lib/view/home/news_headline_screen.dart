import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../custom_widgets/news_tile_widget.dart';
import '../detailPage/news_detail_screen.dart';

class NewsHeadLineScreen extends StatelessWidget {
  const NewsHeadLineScreen({Key? key, required this.newsHeadlineController})
      : super(key: key);
  final NewsHeadlineController newsHeadlineController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          _offsetPopup(),
          Expanded(
            child: ListView.builder(
              itemCount:
                  newsHeadlineController.newsHeadline.value.articles?.length ??
                      0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    newsHeadlineController.articles = newsHeadlineController
                        .newsHeadline.value.articles![index];
                    Get.to(const NewsDetailScreen());
                  },
                  child: Hero(
                    tag: newsHeadlineController
                        .newsHeadline.value.articles![index].title!,
                    child: LocationListItem(
                      imageUrl: newsHeadlineController
                              .newsHeadline.value.articles?[index].urlToImage ??
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                      name: newsHeadlineController
                              .newsHeadline.value.articles?[index].title ??
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
              newsHeadlineController.selectedCountryCode.value = 'in';
              newsHeadlineController.fetchNewsHeadline(countryName: 'in');
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
              newsHeadlineController.selectedCountryCode.value = 'ca';
              newsHeadlineController.fetchNewsHeadline(countryName: 'ca');
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
              newsHeadlineController.selectedCountryCode.value = 'us';
              newsHeadlineController.fetchNewsHeadline(countryName: 'us');
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
                newsHeadlineController.getCountryName().value,
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
