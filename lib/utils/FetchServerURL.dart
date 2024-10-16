import 'package:shared_preferences/shared_preferences.dart';

Future<String> readServerUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('server_url') ?? 'No URL configured';
}
