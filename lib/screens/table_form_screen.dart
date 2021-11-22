import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/table_form_widget.dart';

class TableFormScreen extends StatefulWidget {
  const TableFormScreen({Key? key}) : super(key: key);

  @override
  _TableFormScreenState createState() => _TableFormScreenState();
}

class _TableFormScreenState extends State<TableFormScreen> {
  int? sortColumnIndex;
  bool isAscending = false;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: TableFormWidget()),
    );
  }
}
