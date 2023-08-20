import 'package:flutter/material.dart';
import 'package:project_socket_chat_app/CustomUI/button_card.dart';
import 'package:project_socket_chat_app/CustomUI/contact_card.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Screens/create_group_screen.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contact = [
      ChatModel("Dev Stack", "A full stack developer"),
      ChatModel("Balram", "Flutter developer"),
      ChatModel("Saket", "Developer"),
      ChatModel("Dev ", "App developer"),
      ChatModel("Dev Stack", "A full stack developer"),
      ChatModel("Balram", "Flutter developer"),
      ChatModel("Saket", "Developer"),
      ChatModel("Dev ", "App developer"),
      ChatModel("Dev Stack", "A full stack developer"),
      ChatModel("Balram", "Flutter developer"),
      ChatModel("Saket", "Developer"),
      ChatModel("Dev ", "App developer"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "256 contacts",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 26),
          ),
          PopupMenuButton(
            onSelected: (value) {
              // ignore: avoid_print
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: contact.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const CreateGroupScreen()));
              },
              child: const ButtonCard(
                name: "New Group",
                icon: Icons.group,
              ),
            );
          } else if (index == 1) {
            return const ButtonCard(
              name: "New Contact",
              icon: Icons.person_add,
            );
          }
          return ContactCard(contact: contact[index - 2]);
        },
      ),
    );
  }
}
