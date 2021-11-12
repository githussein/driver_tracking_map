import 'package:coding_challenge/providers/drivers_data_provider.dart';
import 'package:coding_challenge/screens/table_form_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
      create: (context) => DriversDataProvider(),
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
  void _fetchDataFromTheServer() async {
    await Provider.of<DriversDataProvider>(context, listen: false)
        .fetchDriversData();
    setState(() {});
    // final url = Uri.parse('http://192.168.0.103:3000');
    // final response = await http.get(url);
    //
    // // print('Status: ${response.statusCode}, Length: ${response.contentLength}');
    // extractedData = json.decode(response.body) as List;
    // // for (int i = 0; i < 3; i++) {
    // //   print(extractedData[i]);
    // // }
    // //
    // setState(() {
    //   print(extractedData.length);
    // });
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      //fetch drivers data
      Provider.of<DriversDataProvider>(context).fetchDriversData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : BottomNavScreen(),
    );
  }

  Widget myListView() {
    var driversData =
        Provider.of<DriversDataProvider>(context, listen: false).items;
    return driversData.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Text('Objects: ${driversData.length}'),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: driversData.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              leading: Text(
                                driversData[index].driverName.toString(),
                              ),
                              title: Text(
                                driversData[index].carMake.toString(),
                              ),
                              trailing: Text(
                                driversData[index].driverLanguage.toString(),
                              ),
                            ),
                            const Divider(height: 10, color: Colors.lightBlue)
                          ],
                        )),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: _fetchDataFromTheServer,
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.cloud_download),
            // ),
          );
  }
}
