import 'dart:convert';
import 'package:http/http.dart' as http;
import 'FetchServerURL.dart';
import 'FetchAuthToken.dart';

class ApiService {
  Future<List<dynamic>?> fetchFields(int tableId) async {
    try {
      final serverUrl = await readServerUrl();
      final authToken = await readAuthToken();
      final url = Uri.parse('$serverUrl/api/database/fields/table/$tableId/');
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
    try {
      final serverUrl = await readServerUrl();
      final authToken = await readAuthToken();
      final newUrl = Uri.parse('$serverUrl/api/database/rows/table/$tableId/')
          .replace(queryParameters: {'user_field_names': 'true'});

      final response = await http.get(
        newUrl,
        headers: {
          'Authorization': 'Token $authToken',
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
}
