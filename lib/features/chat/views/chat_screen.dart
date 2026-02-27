import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/features/chat/bloc/chat_bloc.dart';
import 'package:docai_assistant/features/chat/bloc/chat_state.dart';
import 'package:docai_assistant/features/chat/data/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme_colors.dart';
import '../bloc/chat_event.dart';
import '../widgets/type_writer_text.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  List<ChatMessage> messages = [];

  // final List<ChatMessage> messages = [
  //   ChatMessage(
  //     text:
  //         "Hello! I've finished analyzing your 2024 Strategic Planning document. I'm ready to answer any questions or help you draft the executive summary.",
  //     isUser: false,
  //     time: "10:42 AM",
  //   ),
  //   ChatMessage(
  //     text:
  //         "Great! Can you summarize the key financial risks mentioned in section 3? Focus on the market volatility part.",
  //     isUser: true,
  //     time: "10:43 AM",
  //   ),
  //   ChatMessage(
  //     text:
  //         "Based on Section 3, the document highlights three main market risks:\n\n"
  //         "1. Currency Fluctuation: High exposure to EUR/USD volatility.\n"
  //         "2. Interest Rates: Potential impact on debt servicing costs.\n"
  //         "3. Emerging Markets: Political instability in the SE Asia expansion zone.",
  //     isUser: false,
  //     time: "10:44 AM",
  //   ),
  // ];

  // void _sendMessage() {
  //   if (_controller.text.trim().isEmpty) return;
  //
  //   setState(() {
  //     messages.add(
  //       ChatMessage(
  //         text: _controller.text.trim(),
  //         isUser: true,
  //         time: _formatTime(),
  //       ),
  //     );
  //   });
  //
  //   _controller.clear();
  // }

  String _formatTime() {
    final now = TimeOfDay.now();
    return now.format(context);
  }

  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatBloc>().add(SendChatMessage(text));
      _controller.clear();
      setState(() {
        _lastWords = '';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                final messages = state.messages; //from bloc only
                return Expanded(
                  child: messages.isNotEmpty
                      ? ListView.builder(
                          key: const PageStorageKey('chat_list'),
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return KeyedSubtree(
                              key: ValueKey(message.id),
                              child: _chatBubble(message, context),
                            );
                          },
                        )
                      : _emptyView(),
                );
              },
            ),
            _inputBar(context),
          ],
        ),
      ),
    );
  }

  /* ---------------- CHAT BUBBLE ---------------- */

  Widget _chatBubble(ChatMessage msg, context) {
    final isUser = msg.isUser;
    final theme = Theme.of(context);
    final colors = theme.extension<AppThemeColors>()!;

    Widget content;

    // 1️⃣ Typing indicator
    if (msg.isTyping) {
      content = const TypingIndicator();
    }
    // 2️⃣ Typewriter animation
    else if (!isUser && msg.animate) {
      content = TypeWriterText(
        text: msg.text,
        style: TextStyle(color: colors.botText, fontSize: 14),

        onCompleted: () {
          context.read<ChatBloc>().add(MarkMessageAnimated(msg.id));
        },
      );
    }
    // 3️⃣ Normal text
    else {
      content = Text(
        msg.text,
        style: TextStyle(
          color: isUser ? colors.userText : colors.botText,
          fontSize: 14,
          height: 1.4,
        ),
      );
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: isUser ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isUser
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: content,
      ),
    );
  }

  /* ---------------- SUGGESTIONS ---------------- */

  Widget _suggestions() {
    return Wrap(
      children: [
        _chip("Summarize PDF"),
        _chip("Check Grammar"),
        _chip("Extract Dates"),
        _chip("Rewrite"),
      ],
    );
  }

  Widget _chip(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          _controller.text = text;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).extension<AppThemeColors>()?.textPrimary,
          ),
        ),
      ),
    );
  }

  /* ---------------- INPUT BAR ---------------- */

  Widget _inputBar(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          // IconButton(
          //   icon: const Icon(Icons.add, color: Colors.grey),
          //   onPressed: () {},
          // ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,

                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                // suffixIcon: IconButton(
                //   icon: const Icon(Icons.clear),
                //   onPressed: _controller.text.isEmpty
                //       ? null
                //       : () {
                //     setState(() { _controller.clear(); });
                //         },
                // ),
              ),

              onSubmitted: (value) => _sendMessage(),
            ),
          ),

          // const SizedBox(width: 6),
          IconButton(
            icon: Icon(Icons.send, color: AppColors.primary),
            onPressed: _sendMessage,
          ),

          // FloatingActionButton(
          //   elevation: 0,
          //   mini: true,
          //   backgroundColor: const Color(0xFF1F2AFF),
          //   onPressed: _sendMessage,
          //   child: const Icon(Icons.mic,color: Colors.white,),
          // ),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/doc.png', height: 60),
          const SizedBox(height: 12),
          const Text(
            "DocAI : AI Document Assistant",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _suggestions(),
        ],
      ),
    );
  }
}
