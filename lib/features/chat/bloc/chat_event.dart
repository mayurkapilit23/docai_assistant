abstract class ChatEvent {}

class SendChatMessage extends ChatEvent {
  final String userMessage;
  SendChatMessage(this.userMessage);
}

class MarkMessageAnimated extends ChatEvent {
  final String messageId;

  MarkMessageAnimated(this.messageId);
}
