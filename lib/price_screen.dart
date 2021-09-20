import 'package:bitcoin_picker/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String value = '?';

  //TODO 7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. Hint: You'll need a ternary operator.

  //TODO 6: Update this method to receive a Map containing the crypto:price key value pairs. Then use that map to update the CryptoCards.
  void getData() async {
    try {
      // var data = await coinData.getCoinData();
      // double tempRate = data['src_side_base'][0]['rate'];
      // bitCoinUsdRate = tempRate.toInt();

      Map map = await CoinData().getCoinData(selectedCurrency);
      var btcData = map["BTC"];
      String data = 200.00;

      setState(() {
        value = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //TODO: For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TODO 1: Refactor this Padding Widget into a separate Stateless Widget called CryptoCard, so we can create 3 of them, one for each cryptocurrency.
          //TODO 2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
          //TODO 3: You'll need to use a Column Widget to contain the three CryptoCards.
          CryptoCard(
              value: value,
              selectedCurrency: selectedCurrency,
              cryptoName: 'BTC'),
          CryptoCard(
              value: value,
              selectedCurrency: selectedCurrency,
              cryptoName: 'BTC'),
          CryptoCard(
              value: value,
              selectedCurrency: selectedCurrency,
              cryptoName: 'BTC'),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
