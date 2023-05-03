
import 'package:shared_preferences/shared_preferences.dart';

class UserNameSharedPreferences {

  Future<void> addUsernameToSF(String user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user',user);
  }

  Future<String> getUsernameValueSF() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user')?? '';
    return user;
  }
}