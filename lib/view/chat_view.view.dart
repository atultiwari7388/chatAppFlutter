import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupchatapp/services/database_service.services.dart';
import 'package:groupchatapp/view/group_info.view.dart';
import 'package:groupchatapp/widgets/widgets.dart';

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
  Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void initState() {
    super.initState();
    getChatAndAdmin();
  }

  getChatAndAdmin() {
    DatabaseServices().getChats(widget.groupId).then((newValue) {
      setState(() {
        chats = newValue;
      });
    });

    DatabaseServices().getGroupAdmin(widget.groupId).then((newValue) {
      setState(() {
        admin = newValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
              onPressed: () => nextScreen(
                  context,
                  GroupInfoView(
                    groupId: widget.groupId,
                    groupName: widget.groupName,
                    adminName: admin,
                  )),
              icon: const Icon(Icons.info_outline)),
        ],
      ),
    );
  }
}
