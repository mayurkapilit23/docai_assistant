import 'package:docai_assistant/features/chat/data/models/chat_message.dart';

// abstract class ChatState {}
//
// class ChatInitial extends ChatState {}
//
// class ChatLoading extends ChatState {
//   final List<ChatMessage> messages;
//   ChatLoading(this.messages);
// }
//
// class ChatLoaded extends ChatState {
//   final List<ChatMessage> messages;
//   ChatLoaded(this.messages);
// }
//
// class ChatError extends ChatState {
//   final String message;
//   final List<ChatMessage> messages;
//   ChatError(this.message, this.messages);
// }

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({required this.messages, this.isLoading = false, this.error});

  /// Initial state
  factory ChatState.initial() {
    return const ChatState(messages: []);
  }

  /// Copy method (important for immutability)
  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
