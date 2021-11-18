import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/drivers_provider.dart';

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
        title: 'Coding Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.lightBlue),
        home: const HomeScreen(title: 'Kinexon Coding Challenge'),
      ),
    );
  }
}
