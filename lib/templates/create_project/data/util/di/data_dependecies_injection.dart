import 'package:get_it/get_it.dart';
import '../../../domain/module/example/repository/example_repository.dart';
import '../../module/example/datasource/example_datasource.dart';
import '../../module/example/datasource/remote_example_datasource.dart';
import '../../module/example/repository/impl_example_repository.dart';

class DataDependenciesInjection {
  static Future<void> inject() async {
    GetIt getIt = GetIt.instance;
    
    // Datasource
    getIt.registerFactory<ExampleDatasource>(() => RemoteExampleDatasource());

    
    // Repository
    getIt.registerFactory<ExampleRepository>(() => ImplExampleRepository(remoteDatasource: GetIt.I()));
  }
}
