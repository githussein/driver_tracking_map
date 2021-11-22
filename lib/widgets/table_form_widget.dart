import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/driver.dart';
import '../providers/drivers_provider.dart';
import '../screens/bottom_nav_screen.dart';

// ignore: must_be_immutable
class TableFormWidget extends StatelessWidget {
  TableFormWidget({Key? key}) : super(key: key);

  List<Driver> _driversList = [];

  //Columns
  final columns = [
    'N.',
    'Name',
    'City',
    'Language',
    'Phone',
    'Car',
    'Distance (km)'
  ];

  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(
              label: Text(column),
            ))
        .toList();
  }

  //Cells
  List<DataCell> getCells(List<dynamic> cells) {
    return cells.map((data) => DataCell(Text('$data'))).toList();
  }

  @override
  Widget build(BuildContext context) {
    //Get the recent drivers data
    _driversList = Provider.of<DriversProvider>(context, listen: false).data;

    //Rows
    List<DataRow> getRows(List<Driver> drivers) {
      return drivers.map((Driver driver) {
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
    }

    return _driversList.isEmpty
        ? const Center(child: Text('Drivers table is empty!'))
        : DataTable(
            showCheckboxColumn: false,
            headingRowColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColorLight),
            columnSpacing: 8,
            // dataRowHeight: 32,
            columns: getColumns(columns),
            rows: getRows(_driversList),
          );
  }
}
