import 'dart:async';

import 'package:coding_challenge/Models/driver.dart';
import 'package:coding_challenge/providers/drivers_provider.dart';
import 'package:coding_challenge/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableFormScreen extends StatefulWidget {
  const TableFormScreen({Key? key}) : super(key: key);

  @override
  _TableFormScreenState createState() => _TableFormScreenState();
}

class _TableFormScreenState extends State<TableFormScreen> {
  late List<Driver> _driversList = [];
  int? sortColumnIndex;
  bool isAscending = false;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    _driversList = Provider.of<DriversProvider>(context, listen: false).data;

    return _driversList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: makeTable()),
          );
  }

  Widget makeTable() {
    final columns = [
      'N.',
      'Name',
      'City',
      'Language',
      'Phone',
      'Car',
      'Distance (km)'
    ];

    return DataTable(
      showCheckboxColumn: false,
      headingRowColor:
          MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
      columnSpacing: 8,
      // dataRowHeight: 32,
      columns: getColumns(columns),
      rows: getRows(_driversList),
    );
  }

  //Columns
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  //Rows
  List<DataRow> getRows(List<Driver> drivers) => drivers.map((Driver driver) {
        final cells = [
          drivers.indexOf(driver) + 1,
          driver.driverName,
          driver.driverCityOrigin,
          driver.driverLanguage,
          driver.driverPhone,
          driver.carMake,
          driver.kmDriven
        ];

        return DataRow(
            cells: getCells(cells),
            onSelectChanged: (selected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavScreen(
                        index: 1, driverName: driver.driverName)),
              );
            });
      }).toList();

  //Cells
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
