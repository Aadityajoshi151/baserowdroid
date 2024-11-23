import 'dart:convert';
import 'package:http/http.dart' as http;
import 'FetchServerURL.dart';
import 'FetchAuthToken.dart';

class ApiService {
  late final String serverUrl;
  late final String authToken;

  ApiService() {
    _initializeConfig();
  }

  Future<void> _initializeConfig() async {
    serverUrl = await readServerUrl();
    authToken = await readAuthToken();
  }

  Future<List<dynamic>?> fetchFields(int tableId) async {
    await _ensureConfigInitialized();
    final url = Uri.parse('$serverUrl/api/database/fields/table/$tableId/');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $authToken',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>?> fetchTableRows(int tableId) async {
    //await _ensureConfigInitialized();
    var new_url = Uri.parse(
            'https://baserow.akaza.home/api/database/rows/table/$tableId/')
        .replace(queryParameters: {'user_field_names': 'true'});
    try {
      final response = await http.get(
        new_url,
        headers: {
          'Authorization': 'Token OmShyeW8vl7lnG3mdgKWV7OCAmNU7hO8',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _ensureConfigInitialized() async {
    while (serverUrl.isEmpty || authToken.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }
}
