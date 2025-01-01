import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvConfig {
  static String exampleApikey = dotenv.get('EXAMPLE_API_KEY');
}