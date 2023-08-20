import 'package:flutter/material.dart';
import 'package:project_socket_chat_app/CustomUI/avatar_card.dart';
import 'package:project_socket_chat_app/CustomUI/contact_card.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  List<ChatModel> contacts = [
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
  List<ChatModel> groupMember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add participants",
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groupMember.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    if (contacts[index - 1].select) {
                      groupMember.remove(contacts[index - 1]);
                      contacts[index - 1].select = false;
                    } else {
                      groupMember.add(contacts[index - 1]);
                      contacts[index - 1].select = true;
                    }
                  });
                },
                child: ContactCard(contact: contacts[index - 1]),
              );
            },
          ),
          groupMember.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  contacts[index].select = false;
                                  groupMember.remove(contacts[index]);
                                });
                              },
                              child: AvatarCard(contact: contacts[index]),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
