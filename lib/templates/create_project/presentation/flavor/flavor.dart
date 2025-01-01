import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/services/network_service/example_service/example_flavor.dart';
import 'develop/example_environtment_dev.dart';
import 'production/example_environtment_prod.dart';
import 'quality/example_environtment_quality.dart';
import 'staging/supabase_environtment_staging.dart';

class Flavor {
  static Future<void> initialize(String env) async {
    switch (env.toLowerCase()) {
      case "dev":
        await dotenv.load(fileName: "lib/presentation/flavor/env/dev.env");
        setExampleFlavor(ExampleEnvirontmentDev());
        break;
      case "quality":
        await dotenv.load(fileName: "lib/presentation/flavor/env/quality.env");
        setExampleFlavor(ExampleEnvirontmentQuality());
        break;
      case "staging":
        await dotenv.load(fileName: "lib/presentation/flavor/env/staging.env");
        setExampleFlavor(ExampleEnvirontmentStaging());
        break;
      case "production":
        await dotenv.load(fileName: "lib/presentation/flavor/env/prod.env");
        setExampleFlavor(ExampleEnvirontmentProd());
        break;
      default:
        await dotenv.load(fileName: "lib/presentation/flavor/env/prod.env");
        setExampleFlavor(ExampleEnvirontmentProd());
        break;
    }
  }
}