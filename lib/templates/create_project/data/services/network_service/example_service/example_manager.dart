import 'package:dio/dio.dart';

import '../base_network_service/base_service.dart';
import 'example_service_config.dart';

class ExampleManager extends BaseService {
  static ExampleManager? _instance;
  final ExampleServiceConfig serviceConfig = ExampleServiceConfig();

  factory ExampleManager() {
    _instance ??= ExampleManager._internal();
    return _instance!;
  }

  ExampleManager._internal() : super(additionalInterceptor: _buildAdditionalInterceptors());

  static List<Interceptor> _buildAdditionalInterceptors() {
    final interceptors = <Interceptor>[];
    return interceptors;
  }

  @override
  String get baseUrl => serviceConfig.getBaseUrl;
}
