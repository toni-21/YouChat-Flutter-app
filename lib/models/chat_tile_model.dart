class ChatTile {
  String name;
  String lastMessage;
  String? image;
  String time;
  bool isActive;

  ChatTile(
      {required this.name,
      required this.image,
      required this.isActive,
      required this.time,
      required this.lastMessage});
}
