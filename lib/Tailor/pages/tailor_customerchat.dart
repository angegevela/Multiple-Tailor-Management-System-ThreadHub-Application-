import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Good day! what date can my shirt be done?",
      "isMe": true,
      "time": "12:00",
    },
    {
      "text": "I am in a process of designing some. When do you need them?",
      "isMe": false,
    },
    {"text": "Next month?", "isMe": true, "time": "08:12"},
    {
      "text": "I am almost finish. I will update you as soon as possible.",
      "isMe": false,
    },
    {"text": "Thank you for your patience!", "isMe": false, "time": "08:43"},
    {"text": "Okay! I will looking forward to it.", "isMe": true},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add({"text": _controller.text, "isMe": true});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      backgroundColor: const Color(0xFFBFD6E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xFFBFD6E2),
            child: Text(
              "Allilie Garcia",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: tailorfontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg["isMe"] as bool;

                return Column(
                  crossAxisAlignment: isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFF262633)
                              : Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          msg["text"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: tailorfontSize,
                          ),
                        ),
                      ),
                    ),
                    if (msg["time"] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 30),
                        child: Text(
                          msg["time"],
                          style: TextStyle(
                            fontSize: tailorfontSize,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3D4354),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF9398A7),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black54),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF9398A7)),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
