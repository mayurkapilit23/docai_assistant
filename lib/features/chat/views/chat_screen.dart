import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> messages = [
    ChatMessage(
      text:
          "Hello! I've finished analyzing your 2024 Strategic Planning document. I'm ready to answer any questions or help you draft the executive summary.",
      isUser: false,
      time: "10:42 AM",
    ),
    ChatMessage(
      text:
          "Great! Can you summarize the key financial risks mentioned in section 3? Focus on the market volatility part.",
      isUser: true,
      time: "10:43 AM",
    ),
    ChatMessage(
      text:
          "Based on Section 3, the document highlights three main market risks:\n\n"
          "1. Currency Fluctuation: High exposure to EUR/USD volatility.\n"
          "2. Interest Rates: Potential impact on debt servicing costs.\n"
          "3. Emerging Markets: Political instability in the SE Asia expansion zone.",
      isUser: false,
      time: "10:44 AM",
    ),
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          text: _controller.text.trim(),
          isUser: true,
          time: _formatTime(),
        ),
      );
    });

    _controller.clear();
  }

  String _formatTime() {
    final now = TimeOfDay.now();
    return now.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      /* ---------------- APP BAR ---------------- */
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.lightBackground,
        // leading: const BackButton(color: Colors.blue),
        surfaceTintColor: Colors.transparent,
        // titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.smart_toy, color: Colors.blue),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "AI Document Assistant",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.videocam, color: Colors.grey),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),

      /* ---------------- BODY ---------------- */
      body: SafeArea(
        child: Column(
          children: [
            // _todayChip(),

            Expanded(child: _chatList()),

            _suggestions(),

            _inputBar(),
          ],
        ),
      ),
    );
  }

  /* ---------------- TODAY CHIP ---------------- */

  Widget _todayChip() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Chip(
        backgroundColor: Colors.blue.shade50,
        label: const Text(
          "TODAY",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /* ---------------- CHAT LIST ---------------- */

  Widget _chatList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _chatBubble(messages[index]);
      },
    );
  }

  /* ---------------- CHAT BUBBLE ---------------- */

  Widget _chatBubble(ChatMessage msg) {
    final isUser = msg.isUser;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFF1F2AFF) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
              ],
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            msg.time,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /* ---------------- SUGGESTIONS ---------------- */

  Widget _suggestions() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _chip("Summarize PDF"),
          _chip("Check Grammar"),
          _chip("Extract Dates"),
          _chip("Rewrite"),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () {
          _controller.text = text;
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  /* ---------------- INPUT BAR ---------------- */

  Widget _inputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.grey),
            onPressed: () {},
          ),

          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 6),

          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey),
            onPressed: () {},
          ),

          FloatingActionButton(
            mini: true,
            backgroundColor: const Color(0xFF1F2AFF),
            child: const Icon(Icons.mic),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

/* ---------------- MODEL ---------------- */

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}
