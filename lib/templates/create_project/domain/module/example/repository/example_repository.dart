import 'package:dartz/dartz.dart';
import '../../../../app/exception/custome_failure.dart';
import '../entity/example.dart';
import '../request/request_example.dart';

abstract class ExampleRepository {
  Future<Either<Failure, Example>> getExample(RequestExample request);
} 