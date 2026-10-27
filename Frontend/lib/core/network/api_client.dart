import 'dart:convert';

import 'package:entrecomunidad/core/config/api_config.dart';
import 'package:http/http.dart' as http;

/// Cliente HTTP mínimo. El backend puede inyectar headers (JWT) ampliando esta clase.
class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri(String path) => Uri.parse('${ApiConfig.baseUrl}$path');

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
  }) {
    return _client
        .get(_uri(path), headers: headers)
        .timeout(ApiConfig.timeout);
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final encoded = body is String ? body : jsonEncode(body);
    return _client
        .post(
          _uri(path),
          headers: {
            'Content-Type': 'application/json',
            ...?headers,
          },
          body: encoded,
        )
        .timeout(ApiConfig.timeout);
  }

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final encoded = body is String ? body : jsonEncode(body);
    return _client
        .put(
          _uri(path),
          headers: {
            'Content-Type': 'application/json',
            ...?headers,
          },
          body: encoded,
        )
        .timeout(ApiConfig.timeout);
  }

  Future<http.Response> postFile(
    String path, {
    required String fieldName,
    required List<int> bytes,
    required String filename,
    Map<String, String>? fields,
  }) async {
    final request = http.MultipartRequest('POST', _uri(path));
    if (fields != null) request.fields.addAll(fields);
    request.files.add(
      http.MultipartFile.fromBytes(fieldName, bytes, filename: filename),
    );
    final streamed = await request.send().timeout(ApiConfig.timeout);
    return http.Response.fromStream(streamed);
  }
}
