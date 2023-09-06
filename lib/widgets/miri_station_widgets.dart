import 'package:flutter/material.dart';

void letterTextDialog(BuildContext context, Function onConfirmPressed) {
  TextEditingController _textController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 500,
              height: 500,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/image/letter_paper_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextField(
                maxLines: 7,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '반려동물에게 편지를 작성해봐요',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  // fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onConfirmPressed(); // Callback execution
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(308, 35)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF6B42F8)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(5.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
