import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart' as constants;

Future<String> readAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token') ?? constants.AUTH_TOKEN_DEFAULT_VALUE;
}
