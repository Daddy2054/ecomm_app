import 'package:ecomm_app/flavors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvReader {
  String getEnvFileName(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return ".dev.env";
      case Flavor.qa:
        return ".qa.env";
      case Flavor.uat:
        return ".uat.env";
      case Flavor.prod:
        return ".prod.env";
      default:
        throw Exception(".env file not found");
    }
  }

  String getBaseUrl() {
    return dotenv.get('BASE_URL');
  }
  String getApiKey() {
    return dotenv.get('API_KEY');
  }
}
