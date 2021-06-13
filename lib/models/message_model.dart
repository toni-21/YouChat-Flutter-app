enum MessageType { Text, Audio, Image, Video }
enum MessageStatus { NotSent, NotViewed, Viewed }

class Message {
  String text;
  MessageType messageType;
  MessageStatus messageStatus;
  bool isSender;
  String? createdAt;

  Message(
      {this.text = "",
      this.createdAt,
      required this.messageStatus,
      required this.messageType,
      required this.isSender});
}
