import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupchatapp/services/database_service.services.dart';
import 'package:groupchatapp/shared/styles.shared.dart';

class GroupInfoView extends StatefulWidget {
  const GroupInfoView(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.adminName})
      : super(key: key);

  final String groupId;
  final String groupName;
  final String adminName;

  @override
  State<GroupInfoView> createState() => _GroupInfoViewState();
}

class _GroupInfoViewState extends State<GroupInfoView> {
  Stream? members;

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  getMembers() async {
    DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((newValue) {
      setState(() {
        members = newValue;
      });
    });
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  //string  manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Info"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: lightText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group: ${widget.groupName}",
                        style: headingText.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "Admin: ${getName(widget.adminName)}",
                        style: lightText.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //members list
            memberList(),
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data["members"] != null) {
            if (snapshot.data["members"].length != 0) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data["members"].length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          getName(snapshot.data["members"][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: lightText.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(getName(snapshot.data["members"][index])),
                      subtitle: Text(getId(snapshot.data["members"][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS "),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS "),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
