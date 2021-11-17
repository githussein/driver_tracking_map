import 'dart:convert';
import 'package:coding_challenge/Models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/driver.dart';

class DriversProvider with ChangeNotifier {
  //**** IMPORTANT: Edit this field with your device ip address *****//
  /*
    Instead of using http://localhost please consider using:
    Android emulator: http://10.0.2.2 or
    iOS emulator: http://127.0.0.1 or
    real device ip address
  */
  static const ipAddress = 'http://192.168.0.103'; //tested on a real device
  List<Driver> _driversData = [];

  List<Driver> get data {
    return [..._driversData]; //return a copy
  }

  Future<void> fetchDriversData() async {
    final url = Uri.parse('$ipAddress:3000');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;

      final List<Driver> loadedCouponsList = [];

      for (var driver in extractedData) {
        loadedCouponsList.add(Driver(
          driverName: driver['driverName'] ?? '',
          driverCityOrigin: driver['driverCityOrigin'] ?? '',
          driverLanguage: driver['driverLanguage'] ?? '',
          driverPhone: driver['driverPhone'] ?? '',
          driverGender: driver['driverGender'] ?? '',
          driverInfo: driver['driverInfo'] ?? '',
          carMake: driver['carMake'] ?? '',
          kmDriven: driver['kmDriven'] ?? 0,
          location: driver['location'] ?? ['000.000', '000.000'],
        ));
      }

      _driversData = loadedCouponsList;
      notifyListeners();
    } catch (error) {
      throw HttpException('Could not fetch data from the server.');
    }
  }
}
