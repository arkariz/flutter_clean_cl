import '../model/example_model.dart';

abstract class ExampleDatasource {
  Future<ExampleModel> getExample();
}