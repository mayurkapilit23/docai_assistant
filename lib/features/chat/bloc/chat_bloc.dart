import 'package:docai_assistant/features/chat/data/models/chat_message.dart';
import 'package:docai_assistant/features/chat/data/repo/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo repo;
  final _uuid = const Uuid();
  // List<ChatMessage> messages = [];

  ChatBloc(this.repo) : super(ChatState.initial()) {
    //send user use to api
    on<SendChatMessage>(_sendChatMessage);
    on<MarkMessageAnimated>(_markAnimated);
  }

  Future<void> _sendChatMessage(
    SendChatMessage event,
    Emitter<ChatState> emit,
  ) async {
    final List<ChatMessage> updatedMessages = List.from(state.messages);

    // 1 Add user message
    updatedMessages.add(
      ChatMessage(
        id: _uuid.v4(), // 👈 unique,
        text: event.userMessage,
        isUser: true,
      ),
    );

    // 2 Add typing indicator
    final typingMsg = ChatMessage(
      id: "typing-${_uuid.v4()}",
      text: "",
      isUser: false,
      isTyping: true,
    );

    // // add user message
    // messages.add(
    //   ChatMessage(text: event.userMessage, isUser: true,),
    // );

    updatedMessages.add(typingMsg);

    // Emit loading (with typing)
    emit(
      state.copyWith(
        messages: List.from(updatedMessages),
        isLoading: true,
        error: null,
      ),
    );

    // emit(ChatLoading(List.from(updatedMessages)));
    try {
      final response = await repo.sendMessage(event.userMessage);
      updatedMessages.removeWhere((m) => m.isTyping);
      updatedMessages.add(
        ChatMessage(
          id: _uuid.v4(),
          text: response,
          isUser: false,
          animate: true, // 👈 important
        ),
      );

      // emit(ChatLoaded(List.from(updatedMessages)));
      emit(
        state.copyWith(
          messages: List.from(updatedMessages),
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      // Remove typing if error
      // messages.removeWhere((m) => m.isTyping);
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _markAnimated(
    MarkMessageAnimated event,
    Emitter<ChatState> emit,
  ) async {
    final updated = state.messages.map((msg) {
      if (msg.id == event.messageId) {
        return msg.copyWith(animate: false);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updated));
  }
}
