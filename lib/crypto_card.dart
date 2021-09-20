import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CryptoCard extends StatelessWidget {
  final String value;
  final String selectedCurrency;
  final String cryptoName;

  CryptoCard(
      {required this.value,
      required this.selectedCurrency,
      required this.cryptoName});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoName = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
