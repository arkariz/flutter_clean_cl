import 'package:dartz/dartz.dart';

import '../../../../app/exception/custome_failure.dart';
import '../../../../domain/module/example/entity/example.dart';
import '../../../../domain/module/example/repository/example_repository.dart';
import '../../../../domain/module/example/request/request_example.dart';
import '../../../util/handler/repository_handler.dart';
import '../datasource/example_datasource.dart';

class ImplExampleRepository extends RepositoryHandler implements ExampleRepository {
  ImplExampleRepository({required this.remoteDatasource});
  
  final ExampleDatasource remoteDatasource;

  @override
  Future<Either<Failure, Example>> getExample(RequestExample request) {
    throw UnimplementedError();
  }
}