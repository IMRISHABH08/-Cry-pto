import 'package:flutter/cupertino.dart';
import 'package:fluttersync/model/dashboard_data.dart';
import 'package:fluttersync/model/grid_column_name.dart';
import 'package:fluttersync/model/currency_mapping.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyProvider extends ChangeNotifier {
  CurrencyDataSource currencyDataSource;

   List<Currency> currencies = [];

  CurrencyProvider() {
    loadCurrencies();
    
  }

  Future loadCurrencies() async {
    
    final currencies = await DashBoardData.getCurrencies();
    this.currencies = currencies;
    currencyDataSource = CurrencyDataSource(currencies: currencies);
    notifyListeners();
  }
}
