import 'package:flutter/material.dart';
import 'package:project_socket_chat_app/CustomUI/custom_card.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Screens/select_contact_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatmodels, required this.sourchat});
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectContactScreen()));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourchat: widget.sourchat,
        ),
      ),
    );
  }
}
