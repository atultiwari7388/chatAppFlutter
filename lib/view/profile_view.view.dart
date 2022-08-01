import 'package:flutter/material.dart';
import 'package:groupchatapp/services/auth_service.services.dart';
import 'package:groupchatapp/shared/styles.shared.dart';
import 'package:groupchatapp/view/home.view.dart';
import '../widgets/widgets.dart';
import 'auth/login_view.view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.userName, required this.email})
      : super(key: key);
  final String userName;
  final String email;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 1.0,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back_ios),
        // ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            const Icon(Icons.account_circle, size: 150),
            const SizedBox(height: 10),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: lightText.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(height: 30),
            const Divider(height: 2),
            ListTile(
              onTap: () => nextScreen(context, const HomeView()),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: const Icon(Icons.groups_rounded),
              title:
                  const Text("Groups", style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
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
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout"),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(fontSize: 17.0),
                ),
                Text(
                  widget.userName,
                  style: const TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 17.0),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(fontSize: 17.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
