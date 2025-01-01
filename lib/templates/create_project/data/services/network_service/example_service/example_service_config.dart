import 'dart:io';
import 'example_flavor.dart';

class ExampleServiceConfig {
  static final ExampleServiceConfig _instance = ExampleServiceConfig._internal();
  factory ExampleServiceConfig() => _instance;
  ExampleServiceConfig._internal();

  String get getBaseUrl => exampleFlavorValue.baseUrl;
  String get _nameApiKey => exampleFlavorValue.apikey;

  String _accessToken = "";
  Map<String, String> get tokenHeader => {
    "apikey": _nameApiKey,
    HttpHeaders.authorizationHeader: "Bearer $_accessToken",
  };

  void updateAccessToken(String token) {
    _accessToken = token;
  }
}