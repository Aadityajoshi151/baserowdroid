import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart' as constants;

Future<String> readServerUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('server_url') ?? constants.SERVER_URL_DEFAULT_VALUE;
}
