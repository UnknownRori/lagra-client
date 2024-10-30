import 'package:lagra_client/env.dart';

class Storage {
  static String resolve(String uri) {
    var api = Environment.API_URL;
    var storage = uri;
    var url = "https://$api/$storage";
    return url;
  }
}
