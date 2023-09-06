import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  // final String imageAsset;

  OnboardingData(this.title, this.description);
}

final onboardingPages = [
  OnboardingData("미리별",
      "미리별은 은하수의 별이라는 뜻으로 \n반려동물에게 하지 못한 말들을\n편지로 적어 우주로 보낼 수 있는 공간입니다."),
  OnboardingData("미리별", "편지는 사랑스러운 당신의 반려동물에게\n잘 전달 될 것입니다."),
  OnboardingData("미리별", "미리별 정류장에서\n당신의 마음을 위로합니다."),
];

class MiriStationOnboarding extends StatefulWidget {
  final VoidCallback onCompleted;

  @override
  MiriStationOnboarding({required this.onCompleted});

  _MiriStationOnboardingState createState() => _MiriStationOnboardingState();
}

class _MiriStationOnboardingState extends State<MiriStationOnboarding> {
  int currentPage = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (currentPage < onboardingPages.length - 1) {
            _controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else {
            widget.onCompleted();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/blue_cosmos.png',
                fit: BoxFit.cover,
              ),
            ),
            PageView.builder(
              controller: _controller,
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (ctx, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 150.0),
                      child: Text(
                        onboardingPages[index].description,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
            // Uncomment the below Positioned widget if you want to show the page indicator dots
            // Positioned(
            //   bottom: 20,
            //   left: 0,
            //   right: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(onboardingPages.length, (index) {
            //       return Container(
            //         margin: const EdgeInsets.all(4),
            //         width: 10,
            //         height: 10,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: currentPage == index ? Colors.blue : Colors.grey,
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
