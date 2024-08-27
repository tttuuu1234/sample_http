import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sample_http/exception.dart';

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
      final url = Uri.parse('$baseUrl/$path');
      final headers = defaultHeaders;
      final response = await _client.get(
        url,
        headers: headers,
      );
      return _handleResponse(response);
    } on BadRequestException catch (_) {
      throw BadRequestException();
    } on NotFoundException catch (_) {
      throw NotFoundException();
    } on UnexpectedException catch (_) {
      throw UnexpectedException();
    } on SocketException catch (_) {
      throw const SocketException('接続に失敗しました。');
    } on FormatException catch (_) {
      throw const FormatException('変換に失敗しました。');
    } on Exception catch (_) {
      throw Exception('エラーが発生しました。');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final body = response.body;
        final encodeBody = jsonEncode(body);
        return {'data': encodeBody};
      case 400:
        throw BadRequestException();
      case 404:
        throw NotFoundException();
      case 422:
        throw UnprocessableEntityException();
      default:
        throw UnexpectedException();
    }
  }
}
