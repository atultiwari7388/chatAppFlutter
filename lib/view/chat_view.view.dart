import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
  }) : super(key: key);
  final String groupId;
  final String groupName;
  final String userName;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat view"),
      ),
    );
  }
}
