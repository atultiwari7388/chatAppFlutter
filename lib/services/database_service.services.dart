import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;

  DatabaseServices({this.uid});

  //reference for user collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  //reference for group collections
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  //updating the user data
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }
}
