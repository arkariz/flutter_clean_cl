/*
import '../../../services/network_service/example_service/example_manager.dart';
import '../../../services/network_service/example_service/example_service_config.dart';
import '../../../util/handler/datasource_handler.dart';
import '../model/{{fileName}}_model.dart';
import '{{fileName}}_datasource.dart';

class Remote{{name}}Datasource extends DatasourceHandler implements {{name}}Datasource {
  Remote{{name}}Datasource({
    required this.exampleManager,
    required this.exampleServiceConfig,
  });

  final ExampleManager exampleManager;
  final ExampleServiceConfig exampleServiceConfig;

  @override
  Future<{{name}}Model> get{{name}}() async {
    final response = await handleRequest(() async {
      return exampleManager.get(
        endpoint: _Endpoint.get{{name}},
        additionalHeaders: exampleServiceConfig.tokenHeader,
      );
    });

    return handleDecode(() => {{name}}Model.fromJson(response));
  }
}

class _Endpoint {
  static const String get{{name}} = "/{{name}}";
}
*/