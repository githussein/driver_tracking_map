import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/driver.dart';

class DriversProvider with ChangeNotifier {
  List<Driver> _driversData = [];

  List<Driver> get data {
    return [..._driversData]; //return a copy
  }

  Future<void> fetchDriversData() async {
    final url = Uri.parse('http://192.168.0.103:3000');
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
      rethrow;
    }
  }
}
