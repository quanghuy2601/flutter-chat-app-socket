import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Screens/individual_screen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualScreen(
                      chatModel: chatModel,
                      sourchat: sourchat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/icons/group.svg" : "assets/icons/person.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
                width: 35,
                height: 35,
              ),
            ),
            title: Text(
              chatModel.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 5),
                Text(
                  chatModel.currentMessage,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
