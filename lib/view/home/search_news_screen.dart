import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/controller/search_screen_controller.dart';
import 'package:news_app/custom_widgets/news_tile_widget.dart';
import 'package:news_app/view/detailPage/news_detail_screen.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  TextEditingController searchTextCtr = TextEditingController();
  final controller = Get.put<SearchScreenController>(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 35, color: Colors.black),
        centerTitle: true,
        title: const Text('Search News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
            child: AnimSearchBar(
              color: Colors.lightBlue[300],
              rtl: true,
              helpText: 'Search News..',
              textFieldColor: Colors.cyan[100],
              width: 400,
              textController: searchTextCtr,
              closeSearchOnSuffixTap: true,
              onSuffixTap: () {
                setState(() {
                  searchTextCtr.clear();
                });
              },
              onSubmitted: (string) {
                controller.fetchSearchHeadline(searchText: searchTextCtr.text);
              },
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Expanded(
            child: Obx(() {
              return controller.isNewsLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.isError.value
                      ? Center(
                          child: Text(controller.errorMessage.value),
                        )
                      : controller.newsArticles.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.newsArticles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    final newsHeadlineController =
                                        Get.find<NewsHeadlineController>();
                                    newsHeadlineController.articles =
                                        controller.newsArticles[index];
                                    Get.to(const NewsDetailScreen());
                                  },
                                  child: Hero(
                                    tag: controller.newsArticles[index].title!,
                                    child: LocationListItem(
                                      imageUrl: controller
                                              .newsArticles[index].urlToImage ??
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                      name: controller
                                              .newsArticles[index].title ??
                                          '',
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                'No Data',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            );
            }),
          )
        ],
      ),
    );
  }
}
