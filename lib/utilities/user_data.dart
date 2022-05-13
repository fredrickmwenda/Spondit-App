import 'package:iot_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final String _fullName = 'first_name';
  final String _id = 'user_id';
  final String _email = 'email';
  final String _accessToken = 'access_token';
  final String _refreshToken = 'refresh_token';
  final String _userActive = 'user_active';

  Future<bool> getClientLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_userActive) ?? false;
  }

  Future<String> getClientFullName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_fullName) ?? '';
  }

  Future<String> getClientEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_email) ?? '';
  }

  Future<String> getClientAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_accessToken) ?? '';
  }

  Future<String> getClientRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_refreshToken) ?? '';
  }

  Future<int> getClientId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_id) ?? 0;
  }

  Future<bool> saveClient(User client) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(_fullName, client.fullName);
      preferences.setString(_email, client.email);
      preferences.setString(_accessToken, client.accessToken);
      preferences.setString(_refreshToken, client.refreshToken);
     // preferences.setInt(_id, client.id);
     // preferences.setBool(_userActive, true);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}