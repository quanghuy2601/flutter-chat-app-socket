// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_socket_chat_app/CustomUI/own_message_card.dart';
import 'package:project_socket_chat_app/CustomUI/reply_message_card.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  bool _showEmoji = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _showEmoji = false;
        });
      }
    });
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.1.40:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      // ignore: avoid_print
      print("Connected");
      socket.on("message", (msg) {
        // ignore: avoid_print
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
    // ignore: avoid_print
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit(
      "message",
      {"message": message, "sourceId": sourceId, "targetId": targetId},
    );
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
      type,
      message,
      DateTime.now().toString().substring(10, 16),
    );
    // ignore: avoid_print
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup ? "assets/icons/group.svg" : "assets/icons/person.svg",
                        // ignore: deprecated_member_use
                        color: Colors.white,
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    // ignore: avoid_print
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "View Contact",
                        child: Text("View Contact"),
                      ),
                      const PopupMenuItem(
                        value: "Media, links and docs",
                        child: Text("Media, links and docs"),
                      ),
                      const PopupMenuItem(
                        value: "Chat Web",
                        child: Text("Chat Web"),
                      ),
                      const PopupMenuItem(
                        value: "Search",
                        child: Text("Search"),
                      ),
                      const PopupMenuItem(
                        value: "Mute",
                        child: Text("Mute"),
                      ),
                      const PopupMenuItem(
                        value: "Wallpaper",
                        child: Text("Wallpaper"),
                      ),
                    ];
                  },
                )
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (_showEmoji) {
                  setState(() {
                    _showEmoji = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        sendButton = false;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            _showEmoji = !_showEmoji;
                                          });
                                        },
                                        icon: const Icon(Icons.emoji_emotions_outlined),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (builder) => bottomSheet(),
                                              );
                                            },
                                            icon: const Icon(Icons.attach_file),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.camera_alt),
                                          ),
                                        ],
                                      ),
                                      contentPadding: const EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: const Color(0xFF128C7E),
                                  child: IconButton(
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                          _scrollController.position.maxScrollExtent,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        sendMessage(
                                          _controller.text,
                                          widget.sourchat.id,
                                          widget.chatModel.id,
                                        );
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _showEmoji ? selectEmoji() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(width: 40),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(width: 40),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(width: 40),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(width: 40),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget selectEmoji() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: EmojiPicker(
        onBackspacePressed: () {
          _controller
            ..text = _controller.text.characters.toString()
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
        },
        textEditingController: _controller,
        config: Config(
          backspaceColor: const Color.fromARGB(255, 234, 248, 255),
          columns: 8,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        ),
      ),
    );
  }
}
