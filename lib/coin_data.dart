import 'dart:convert';

import 'package:http/http.dart' as http;

const String url =
    'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=72A339CA-0FEF-4835-B6E1-70A9E3B00D59';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  dynamic getCoinData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var json = jsonDecode(data);
      print('Json: $json');

      return json;
    } else {
      print('{response.statusCode}: ${response.statusCode}');
    }
  }
}
