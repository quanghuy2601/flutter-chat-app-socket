import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_socket_chat_app/Models/chat_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey[200],
                child: SvgPicture.asset(
                  "assets/icons/person.svg",
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 30,
                  width: 30,
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            contact.name,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
