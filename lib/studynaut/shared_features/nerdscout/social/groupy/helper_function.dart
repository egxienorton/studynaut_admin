import 'package:shared_preferences/shared_preferences.dart';

import '../../../BLOC/Bindings and Imports/firequickie.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  // saving the data to SF

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  // the fields had email and password parsed in
  static Future<bool> saveUserNameSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return await sf.setString(userNameKey, auth.currentUser!.uid);
  }

  static Future<bool> saveUserEmailSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return await sf.setString(userEmailKey, auth.currentUser!.email!);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}
