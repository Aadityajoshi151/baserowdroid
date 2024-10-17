import 'package:shared_preferences/shared_preferences.dart';

Future<String> readAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token') ?? 'No token configured';
}
