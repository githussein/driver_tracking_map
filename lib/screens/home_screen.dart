import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'bottom_nav_screen.dart';
import '../providers/drivers_provider.dart';
import '../widgets/fetching_indicator_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = true;
  var _isError = false;

  @override
  void initState() {
    _fetchDataFromServer();
    super.initState();
  }

  Future<void> _fetchDataFromServer() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<DriversProvider>(context, listen: false)
        .fetchDriversData()
        .then((_) => setState(() {
              if (_isError) Navigator.of(context).pop();
              _isError = false;
              _isLoading = false;
            }))
        .onError((error, stackTrace) {
      _isError = true;
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Could not fetch data from the server.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: const Text('Try again'))
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) _fetchDataFromServer();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const FetchingIndicator()
          : const BottomNavScreen(index: 0, driverName: ''),
    );
  }
}
