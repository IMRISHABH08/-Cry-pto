import 'dart:convert';

import 'currency_mapping.dart';
import 'package:http/http.dart' as http;

class DashBoardData {
  static final apikey = "72ed0928158403c0fb9dabc7feb50721bbbdf17e";

  static Future<List<Currency>> getCurrencies() async {
    final url =
        "https://api.nomics.com/v1/currencies/ticker?key=$apikey&&interval=1d,1h&per-page=30&page=1";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      print(" response " + body.toString());
      List<Currency> data = body.map((e) => Currency.fromjson(e)).toList();
      return data??"";
    } else {
      throw Exception("Failed to load by me");
    }
  }
}
