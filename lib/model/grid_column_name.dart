import 'package:fluttersync/model/currency_mapping.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CurrencyColumn { id, rank, name, price, oneHChange, oneDChange, marketcap }

class CurrencyDataSource extends DataGridSource {
  List<DataGridRow> _currencies;
  @override
  List<DataGridRow> get rows => _currencies;

  CurrencyDataSource({@required List<Currency> currencies}) {
    buildDataGrid(currencies);
  }

  dynamic buildDataGrid(List<Currency> currencies) {
    _currencies = currencies
        .map<DataGridRow>(
          (currency) => DataGridRow(
            cells: CurrencyColumn.values
                .map(
                  (column) => DataGridCell<CurrencyComparable>(
                    columnName: column.toString(),
                    value:
                        CurrencyComparable(column: column, currency: currency),
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    return _currencies;
  }

  DataGridRowAdapter buildRow(DataGridRow row) => DataGridRowAdapter(
      color: Colors.blue,
      cells: row.getCells().map<Widget>((dataGridCell) {
        final CurrencyComparable currencyWrapper = dataGridCell.value;
        final currency = currencyWrapper.currency;
        final column = CurrencyColumn.values
            .firstWhere((value) => value.toString() == dataGridCell.columnName);
        switch (column) {
          case CurrencyColumn.id:
            return buildIdRow(currency);
          case CurrencyColumn.price:
            return buildPriceRow(currency.price);
          case CurrencyColumn.rank:
            return buildRankRow(currency.rank);
          case CurrencyColumn.name:
            return buildNameRow(currency.name);
          case CurrencyColumn.marketcap:
            return buildMarketCapRow(currency.marketCap);
          case CurrencyColumn.oneHChange:
            return build1HRow(currency.oneHourChange);
          case CurrencyColumn.oneDChange:
            return build1DRow(currency.oneDayChange);
          default:
            return Text("Hello ");
        }
      }).toList());

  Widget build1HRow(double one_Hour) => Container(
        padding: EdgeInsets.all(16),
        child: Text("$one_Hour"),
      );
  Widget build1DRow(double one_day) => Container(
        padding: EdgeInsets.all(16),
        child: Text("$one_day"),
      );
  Widget buildMarketCapRow(double marketCap) => Container(
        padding: EdgeInsets.all(16),
        child: FittedBox(
          child: Text(
            ((marketCap * 72.96) / 72925100000).toStringAsFixed(2) + "B",
            textScaleFactor: 1.2,
          ),
        ),
      );
  Widget buildNameRow(String name) => Container(
        padding: EdgeInsets.all(16),
        child: Text("$name"),
      );
  Widget buildRankRow(int rank) => Container(
        padding: EdgeInsets.all(16),
        child: Text("$rank"),
      );

  Widget buildIdRow(Currency currency) => Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            buildLogo(currency),
            SizedBox(
              width: 5,
            ),
            Text(
              currency.id,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildPriceRow(double price) => Container(
        padding: EdgeInsets.all(16),
        child: FittedBox(
          child: Text(
            "\₹ " + (price * 72.96).toStringAsFixed(2),
            textScaleFactor: 1.2,
          ),
        ),
      );
  Widget buildLogo(Currency currency) {
    final isSvg = currency.logoUrl.endsWith('.svg');
    return CircleAvatar(
      radius: 12,
      child: isSvg
          ? SvgPicture.network(currency.logoUrl)
          : Image.network(currency.logoUrl),
    );
  }
}
