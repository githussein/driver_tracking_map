import 'dart:async';

import 'package:coding_challenge/providers/drivers_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/bottom_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DriversProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: const MyHomePage(title: 'Kinexon Coding Challenge'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<DriversProvider>(context, listen: false)
        .fetchDriversData()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    Timer.periodic(const Duration(seconds: 5), (_) {
      Provider.of<DriversProvider>(context, listen: false).fetchDriversData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Fetching data from the server...'),
              ],
            ))
          : const BottomNavScreen(),
    );
  }
}
