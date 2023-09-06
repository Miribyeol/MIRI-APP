import 'package:flutter/material.dart';

class ChallengeListWidget extends StatelessWidget {
  final List<int> challengeStep;
  final Function(int) onChallengeDayPressed;

  const ChallengeListWidget({
    Key? key,
    required this.challengeStep,
    required this.onChallengeDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    double buttonText = 20;
    double buttonSideSize = 5;
    double buttonContentSize = 13;
    double buttonGapSize = 10;
    // double height = 35;
    // double width = 140;
    // double footerTextButtonSize = 13;
    // double contentPaddingSize = 18;
    double buttonSize = 24;
    double contentheight = 111;

    return Scaffold(
      backgroundColor: const Color(0xff121824),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(left: 16.0),
            color: const Color(0xFF121824),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '챌린지',
                  style: TextStyle(
                    fontSize: buttonText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: buttonSideSize),
                Text(
                  '14일동안 미션을 수행해보아요',
                  style: TextStyle(
                    fontSize: buttonContentSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: buttonGapSize),
              ],
            ),
          ),
          backgroundColor: const Color(0xFF121824),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...List.generate(14, (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: contentheight,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff121824), // Shadow color
                            blurRadius: 5.0, // Amount of blur
                            offset: Offset(0, 4), // Offset of the shadow
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          onChallengeDayPressed(index);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              // 챌린지를 완료한 경우 회색
                              challengeStep.contains(index + 1)
                                  ? const Color(0xff1F2839)
                                  // 이전 챌린지를 완료하지 않은 경우 빨간색
                                  : (index + 1 >
                                          (challengeStep.isNotEmpty
                                              ? challengeStep.last + 1
                                              : 1))
                                      ? const Color(0xff1F2839)
                                      // 그 외의 경우 기본 색상
                                      : const Color(0xff6B42F8)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Day ${index + 1}',
                            style: TextStyle(
                              fontSize: buttonSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
