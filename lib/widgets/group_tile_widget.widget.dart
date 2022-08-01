import 'package:flutter/material.dart';
import 'package:groupchatapp/shared/styles.shared.dart';
import 'package:groupchatapp/view/chat_view.view.dart';
import 'package:groupchatapp/widgets/widgets.dart';

class GroupTileWidget extends StatefulWidget {
  const GroupTileWidget(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName})
      : super(key: key);
  final String userName;
  final String groupId;
  final String groupName;

  @override
  State<GroupTileWidget> createState() => _GroupTileWidgetState();
}

class _GroupTileWidgetState extends State<GroupTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextScreen(
        context,
        ChatView(
          groupId: widget.groupId,
          groupName: widget.groupName,
          userName: widget.userName,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: headingText.copyWith(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            widget.groupName,
            style: lightText.copyWith(fontSize: 18, color: Colors.black),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.userName}",
            style: lightText.copyWith(fontSize: 13.0),
          ),
        ),
      ),
    );
  }
}
