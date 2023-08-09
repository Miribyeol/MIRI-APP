import 'package:flutter/material.dart';

class AIConsultingScreen extends StatelessWidget {
  const AIConsultingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '별이와 대화하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'AI에게 하고싶은 말을 보내보세요!',
                    style: TextStyle(
                      color: Color(0xFFBBBBBB),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150.0,
            left: 20.0,
            right: 20.0,
            bottom: 80.0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0D131D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                children: const [
                  MessageBubble(
                      isSent: false, text: '안녕하세요?', isReceived: true),
                  MessageBubble(isSent: true, text: '안녕!', isReceived: false),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: '메시지를 입력하세요',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    // Add logic to send the message
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isSent;
  final bool isReceived;
  final String text;

  const MessageBubble({super.key, 
    required this.isSent,
    required this.text,
    this.isReceived = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSent ? const Color(0xFF1F2839) : const Color(0xFF6B42F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
