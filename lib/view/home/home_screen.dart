import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/view/home/apple_company_news.dart';
import 'package:news_app/view/home/business_headline_list_screen.dart';
import 'package:news_app/view/home/news_headline_screen.dart';
import 'package:news_app/view/home/tesla_news.dart';

import 'search_news_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put<NewsHeadlineController>(
      NewsHeadlineController()..fetchNewsHeadline(countryName: 'in'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const SearchNewsScreen());
              },
              icon: const Icon(
                Icons.search,
                size: 35,
              ))
        ],
      ),
      body: Obx(() {
        return controller.isNewsLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.isError.value
                ? Center(
                    child: Text(controller.errorMessage.value),
                  )
                : DefaultTabController(
                    length: 4,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ButtonsTabBar(
                            onTap: (tabIndex) {
                              if (tabIndex == 0) {
                                controller.fetchNewsHeadline(
                                    countryName:
                                        controller.selectedCountryCode.value);
                              } else if (tabIndex == 1) {
                                controller.fetchBusinessHeadline();
                              } else if (tabIndex == 2) {
                                controller.fetchApplePopularHeadline(
                                    companyName: 'apple');
                              } else if (tabIndex == 3) {
                                controller.fetchTeslaPopularHeadline(
                                    companyName: 'tesla');
                              }
                            },
                            backgroundColor: Colors.orangeAccent,
                            unselectedBackgroundColor: Colors.grey[300],
                            unselectedLabelStyle:
                                const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            tabs: const [
                              Tab(
                                icon: Icon(Icons.newspaper),
                                text: "Headline",
                              ),
                              Tab(
                                icon: Icon(Icons.business),
                                text: "Business",
                              ),
                              Tab(
                                icon: Icon(Icons.apple),
                                text: 'Apple',
                              ),
                              Tab(
                                icon: Icon(Icons.text_fields_rounded),
                                text: 'Tesla',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              NewsHeadLineScreen(
                                newsHeadlineController: controller,
                              ),
                              BusinessHeadLineListScreen(),
                              ApplePopularNewsHeadlines(),
                              TeslaPopularNews(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
