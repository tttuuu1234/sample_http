import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  const ApiClient(
    this._client, {
    required this.baseUrl,
    required this.defaultHeaders,
  });

  final String baseUrl;
  final http.Client _client;
  final Map<String, String> defaultHeaders;

  Future<Map<String, dynamic>> get({
    required String path,
  }) async {
    try {
      final url = Uri.parse(baseUrl);
      final headers = defaultHeaders;
      final response = await _client.get(
        url,
        headers: headers,
      );
      final body = response.body;
      final encodeBody = jsonEncode(body);
      print(encodeBody);
      return encodeBody as Map<String, dynamic>;
    } on Exception catch (e) {
      print(e);
      throw Exception();
    }
  }
}
