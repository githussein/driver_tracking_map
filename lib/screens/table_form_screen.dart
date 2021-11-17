import 'dart:async';

import 'package:coding_challenge/Models/driver.dart';
import 'package:coding_challenge/providers/data_provider.dart';
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

  // @override
  // void initState() {
  //   _driversList = Provider.of<DriversProvider>(context, listen: false).items;
  //
  //   Timer.periodic(const Duration(seconds: 5), (_) async {
  //     await Provider.of<DriversProvider>(context, listen: false)
  //         .fetchDriversData();
  //
  //     setState(() {
  //       _driversList =
  //           Provider.of<DriversProvider>(context, listen: false).items;
  //     });
  //   });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _driversList = Provider.of<DriversProvider>(context, listen: false).data;

    return Scaffold(
      body: _driversList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: makeTable()),
            ),
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
      'Distance(km)'
    ];

    return DataTable(
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

        return DataRow(cells: getCells(cells));
      }).toList();

  //Cells
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
