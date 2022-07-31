import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //key
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving the data to shared pref

  //getting the data from shared pref

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getBool(userLoggedInKey);
  }
}
