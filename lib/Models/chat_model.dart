class ChatModel {
  String name;
  String status;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  bool select = false;
  int id;
  ChatModel([
    this.name = "",
    this.status = "",
    this.icon = "",
    this.isGroup = false,
    this.time = "",
    this.currentMessage = "",
    this.select = false,
    this.id = 0,
  ]);
}
