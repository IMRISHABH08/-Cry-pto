import 'package:flutter/material.dart';
import 'package:fluttersync/model/grid_column_name.dart';
import 'package:fluttersync/provider/currency_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DashboardDataTransform extends StatelessWidget {
  //const DashboardDataTransform({ Key? key }) : super(key: key);

  List<GridColumn> buildGridColumns() {
    return <GridColumn>[
      GridTextColumn(
        columnName: CurrencyColumn.id.toString(),
        label: InkWell(
          splashColor: Colors.blue,
          onTap: (){
            Fluttertoast.showToast(
              msg: "  ID   ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
          },
          child: Container(
            //margin: EdgeInsets.all(5),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
            padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: buildLabel("ID"),
          ),
        ),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.rank.toString(),
        label: Container(
            padding: EdgeInsets.all(10),
            //alignment: Alignment.center,
            child: buildLabel("Rank")),
        maximumWidth: 80,
      ),
      GridTextColumn(
        columnName: CurrencyColumn.name.toString(),
        label: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
          child: buildLabel("Name"),
        ),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.price.toString(),
        label: Container(
          // alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
          child: buildLabel("Price"),
        ),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.oneHChange.toString(),
        label: Container(
          // alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
          child: buildLabel("1H"),
        ),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.oneDChange.toString(),
        label: Container(
          // alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
          child: buildLabel("1D"),
        ),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.marketcap.toString(),
        label: Container(
          // alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
          child: buildLabel("Mar.Cap"),
        ),
      ),
    ];
  }

  Widget buildLabel(String name) => Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
        textScaleFactor: 1.2,
      );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrencyProvider>(context);
    final currencyDataSource = provider.currencyDataSource;

    if (currencyDataSource == null || currencyDataSource.rows.isEmpty) {
      print("Running Circular progress indicator");
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print("returning SfDataGrid");
      return Scaffold(
        body: SfDataGridTheme(
          data: SfDataGridThemeData(
             //gridLineColor: Colors.white30,
             //gridLineStrokeWidth: 2.0,
          ),
          child: SfDataGrid(
            allowSorting: true,
            defaultColumnWidth: 100,
            frozenColumnsCount: 1,
            // verticalScrollPhysics: BouncingScrollPhysics(),
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: currencyDataSource,
            columns: buildGridColumns(),
          ),
        ),
      );
    }
  }
}
