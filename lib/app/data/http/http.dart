import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../domain/either.dart';

class Http {
  Http({
    required Client client,
    required String baseUrl,
    required String apiKey,
  })  : _client = client,
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  final Client _client;
  final String _baseUrl;
  final String _apiKey;

  Future<Either<HttpFailure, String>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParams = const {},
    Map<String, dynamic> body = const {},
    bool needsAuthentication = true,
  }) async {
    try {
      if (needsAuthentication) {}
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );
      if (queryParams.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParams,
        );
      }
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        if (needsAuthentication) 'Authorization': 'Bearer $_apiKey',
        ...headers,
      };
      late final Response response;
      final bodyString = jsonEncode(body);
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(response.body);
      }
      return Either.left(
        HttpFailure(
          statusCode: response.statusCode,
        ),
      );
    } catch (e) {
      // ClientException -> for web
      if (e is SocketException || e is ClientException) {
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }
      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    }
  }
}

class HttpFailure {
  HttpFailure({
    this.statusCode,
    this.exception,
  });

  final int? statusCode;
  final Object? exception;
}

class NetworkException {}

enum HttpMethod { get, post, put, patch, delete }
