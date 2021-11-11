import 'package:coding_challenge/Models/driver.dart';
import 'package:coding_challenge/providers/drivers_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableFormScreen extends StatefulWidget {
  const TableFormScreen({Key? key}) : super(key: key);

  @override
  _TableFormScreenState createState() => _TableFormScreenState();
}

class _TableFormScreenState extends State<TableFormScreen> {
  late List<Driver> _driversList;
  int? sortColumnIndex;
  bool isAscending = false;

  // @override
  // void initState() {
  //   _driversList =
  //       Provider.of<DriversDataProvider>(context, listen: false).items;
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    _driversList =
        Provider.of<DriversDataProvider>(context, listen: false).items;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: buildDataTable()),
        ),
      );

  Widget buildDataTable() {
    final columns = ['N.', 'Name', 'Language', 'Car'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(_driversList),
    );
  }

  //Columns
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            // onSort: onSort,
          ))
      .toList();

  //Rows
  List<DataRow> getRows(List<Driver> drivers) => drivers.map((Driver driver) {
        final cells = [
          drivers.indexOf(driver) + 1,
          driver.driverName,
          driver.driverLanguage,
          driver.carMake
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  //Cells
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     drivers.sort((user1, user2) =>
  //         compareString(ascending, user1.firstName, user2.firstName));
  //   } else if (columnIndex == 1) {
  //     drivers.sort((user1, user2) =>
  //         compareString(ascending, user1.lastName, user2.lastName));
  //   } else if (columnIndex == 2) {
  //     drivers.sort((user1, user2) =>
  //         compareString(ascending, '${user1.age}', '${user2.age}'));
  //   }
  //
  //   setState(() {
  //     this.sortColumnIndex = columnIndex;
  //     this.isAscending = ascending;
  //   });
  // }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
