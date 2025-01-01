import '../../../util/handler/datasource_handler.dart';
import '../model/example_model.dart';
import 'example_datasource.dart';

class RemoteExampleDatasource extends DatasourceHandler implements ExampleDatasource {
  @override
  Future<ExampleModel> getExample() {
    throw UnimplementedError();
  }
}