import 'package:flutter/material.dart';
import 'start.dart';

class OnBoarding extends StatefulWidget {
  @override
  OnBoardingState createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int currentPage = 0;

  static const List<Map<String, dynamic>> pages = [
    {'image': 'assets/image/OnBoarding1.png'},
    {'image': 'assets/image/OnBoarding2.png'},
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (currentPage != pages.length - 1) {
            pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const StartScreen()),
            );
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: pages.length,
          onPageChanged: (index) {
            if (currentPage != index) {
              setState(() {
                currentPage = index;
              });
            }
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(pages[index]['image']),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
