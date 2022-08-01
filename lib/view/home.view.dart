import 'package:flutter/material.dart';
import 'package:groupchatapp/helper/helper_functions.helper.dart';
import 'package:groupchatapp/services/auth_service.services.dart';
import 'package:groupchatapp/shared/styles.shared.dart';
import 'package:groupchatapp/view/auth/login_view.view.dart';
import 'package:groupchatapp/view/profile_view.view.dart';
import 'package:groupchatapp/view/search_view.view.dart';
import 'package:groupchatapp/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = "";
  String email = "";
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });

    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 1.0,
        title: Text(
          "Groups",
          style: headingText.copyWith(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
            onPressed: () => nextScreen(context, const SearchView()),
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            const Icon(Icons.account_circle, size: 150),
            const SizedBox(height: 10),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: lightText.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(height: 30),
            const Divider(height: 2),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: const Icon(Icons.groups_rounded),
              title:
                  const Text("Groups", style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () => nextScreen(
                  context, ProfileView(userName: userName, email: email)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: const Icon(Icons.person_rounded),
              title:
                  const Text("Profile", style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            authServices.signOut().whenComplete(() {
                              nextScreenReplacement(context, const LoginView());
                            });
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    );
                  },
                );
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: const Icon(Icons.logout_rounded),
              title:
                  const Text("Logout", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        onPressed: () {
          popUpDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  popUpDialog(BuildContext context) {}

  groupList() {}
}
