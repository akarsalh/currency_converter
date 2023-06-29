import "dart:convert";

import "package:http/http.dart" as http;

class ApiClient {
  Uri currentURL = Uri.https("api.fastforex.io", "currencies",
      {"api_key": "f5a8d2bb18-8f4a31407b-rwx1zw"});

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currentURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["currencies"];
      List<String> currencies = await (list.keys).toList();
      return currencies;
    } else {
      throw Exception("Failed to connect API");
    }
  }

  Future<double> getRate(String from, String to) async {
    var rateURL =
        "https://v6.exchangerate-api.com/v6/f2a7fa0b6fe0cb6b390575b4/pair/${from}/${to}";

    var res = await http.get(Uri.parse(rateURL));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return body["conversion_rate"];
    } else {
      throw Exception("Failed to connect API");
    }
  }
}
