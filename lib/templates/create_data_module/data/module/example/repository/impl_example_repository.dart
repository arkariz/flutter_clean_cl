/*
import 'package:dartz/dartz.dart';

import '../../../../app/exception/custome_failure.dart';
import '../../../../domain/module/{{fileName}}/entity/{{fileName}}.dart';
import '../../../../domain/module/{{fileName}}/repository/{{fileName}}_repository.dart';
import '../../../../domain/module/{{fileName}}/request/request_{{fileName}}.dart';
import '../../../util/handler/repository_handler.dart';
import '../datasource/{{fileName}}_datasource.dart';

class Impl{{name}}Repository extends RepositoryHandler implements {{name}}Repository {
  Impl{{name}}Repository({required this.remoteDatasource});
  
  final {{name}}Datasource remoteDatasource;

  @override
  Future<Either<Failure, {{name}}>> get{{name}}(Request{{name}} request) async{
    return await handleOperation(
      operationOnline: () async {
        final response = await remoteDatasource.get{{name}}();
        return response.toEntity();
      },
    );
  }
}
*/