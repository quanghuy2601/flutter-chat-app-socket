import 'package:project_socket_chat_app/CustomUI/button_card.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;

  List<ChatModel> chatmodels = [
    ChatModel(
      "Dev Stack",
      "status",
      "person.svg",
      false,
      "4:00",
      "Hi Everyone",
      false,
      1,
    ),
    ChatModel(
      "Kishor",
      "status",
      "person.svg",
      false,
      "13:00",
      "Hi Kishor",
      false,
      2,
    ),
    ChatModel(
      "Collins",
      "status",
      "person.svg",
      false,
      "8:00",
      "Hi Dev Stack",
      false,
      3,
    ),
    ChatModel(
      "Balram Rathore",
      "status",
      "person.svg",
      false,
      "13:00",
      "Hi Dev Stack",
      false,
      4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
                onTap: () {
                  sourceChat = chatmodels.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => HomeScreen(
                                chatmodels: chatmodels,
                                sourchat: sourceChat,
                              )));
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
              )),
    );
  }
}
