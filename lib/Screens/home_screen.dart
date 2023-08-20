import 'package:flutter/material.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';
import 'package:project_socket_chat_app/Screens/camera_page.dart';
import 'package:project_socket_chat_app/Screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.chatmodels, required this.sourchat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App Using Socket"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // ignore: avoid_print
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: "New Group",
                  child: Text("New Group"),
                ),
                PopupMenuItem(
                  value: "New Broadcast",
                  child: Text("New Broadcast"),
                ),
                PopupMenuItem(
                  value: "Chat Web",
                  child: Text("Chat Web"),
                ),
                PopupMenuItem(
                  value: "Starred Messages",
                  child: Text("Starred Messages"),
                ),
                PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              child: Text("CHATS"),
            ),
            Tab(
              child: Text("STATUS"),
            ),
            Tab(
              child: Text("CALLS"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraPage(),
          ChatScreen(
            chatmodels: widget.chatmodels,
            sourchat: widget.sourchat,
          ),
          const Text("Status"),
          const Text("Calls"),
        ],
      ),
    );
  }
}
