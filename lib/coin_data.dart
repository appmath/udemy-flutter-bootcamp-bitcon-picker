import 'dart:convert';

import 'package:http/http.dart' as http;

const String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=';

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '72A339CA-0FEF-4835-B6E1-70A9E3B00D59';

// class CoinData {
//   //TODO 3: Update getCoinData to take the selectedCurrency as an input.
//   Future getCoinData(String currency) async {
//     //TODO 4: Update the URL to use the selectedCurrency input.
//     String requestURL = '$coinAPIURL/BTC/$currency?apikey=$apiKey';
//     http.Response response = await http.get(Uri.parse(requestURL));
//     if (response.statusCode == 200) {
//       var decodedData = jsonDecode(response.body);
//       var lastPrice = decodedData['rate'];
//       return lastPrice;
//     } else {
//       print(response.statusCode);
//       throw 'Problem with the get request';
//     }
//   }
// }

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> map = {};
    for (var crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      // String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];

        map[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //TODO 5: Return a Map of the results instead of a single value.
    print('Map: $map');
    return map;
  }

}
