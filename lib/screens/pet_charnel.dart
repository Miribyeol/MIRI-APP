import 'package:flutter/material.dart';

class PetCharnelScreen extends StatelessWidget {
  const PetCharnelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF121824),
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 440.0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 281.0,
                      height: 440.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // 중앙에 위치하도록 조정
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/image/common-4.jpeg',
                                width: 210.0,
                                height: 247.0,
                              ),
                            ),
                            const SizedBox(height: 10.0), // 간격을 위해 사용
                            const Text(
                              '햄찌',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10.0), // 간격을 위해 사용
                            const Text(
                              '2023.01.01 ~ 2023.07.08',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text positioned at the bottom
            SizedBox(
              height: 155.0,
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                  child: Center(
                    child: Text(
                      '고마워, 햄찌.\n함께한 모든 순간들을 기억할게.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
