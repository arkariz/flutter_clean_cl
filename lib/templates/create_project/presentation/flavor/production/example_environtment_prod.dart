import '../../../data/services/network_service/example_service/example_flavor.dart';
import '../../core/config/dot_env_config.dart';

class ExampleEnvirontmentProd extends ExampleFlavor {
  @override
  String get apikey => DotEnvConfig.exampleApikey;

  @override
  String get baseUrl => "https://potterapi-fedeperin.vercel.app/";

  @override
  String get environtment => "prod";

}