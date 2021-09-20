import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  int bitCoinUsdRate = 0;

  String apiKey = '72A339CA-0FEF-4835-B6E1-70A9E3B00D59';
  String selectedCurrency = 'USD';

  Widget? getPicker() {
    if (Platform.isAndroid) {
      return getAndroidDropdown();
    } else if (Platform.isIOS) {
      return getCupertinoPicker();
    }
  }

  @override
  void initState() {
    updateUI();
  }

  void updateUI() async {
    var data = await coinData.getCoinData();
    double tempRate = data['src_side_base'][0]['rate'];
    bitCoinUsdRate = tempRate.toInt();
  }

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = (value as String);
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> textItems = [];
    for (var currency in currenciesList) {
      var newItem = Text(currency);
      textItems.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print('SelectedIndex: $selectedIndex');
      },
      children: textItems,
    );
  }

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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitCoinUsdRate USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? getAndroidDropdown()
                : getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
