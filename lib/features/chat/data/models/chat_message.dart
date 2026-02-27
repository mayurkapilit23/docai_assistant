class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final bool isTyping;
  final bool animate;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    this.isTyping = false,
    this.animate = false,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isUser,
    bool? isTyping,
    bool? animate,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      isTyping: isTyping ?? this.isTyping,
      animate: animate ?? this.animate,
    );
  }
}

// class ChatMessage {
//   final String text;
//   final bool isUser;
//   final String time;
//
//   ChatMessage({required this.text, required this.isUser, required this.time});
// }
