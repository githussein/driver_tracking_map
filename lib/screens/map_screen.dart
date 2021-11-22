import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../Models/driver.dart';
import '../providers/drivers_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({required this.driverName, Key? key}) : super(key: key);
  final String driverName;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //list to represent the objects of the json file
  late List<Driver> _driversList = [];
  late LatLng driverLocation;
  late Timer timer;

  //list of drivers names for the dropdown button
  final List<String> _driversNames = [];
  String? _selectedDriver;
  int _index = 0;

  //a controller to manipulate the map
  late GoogleMapController _controller;
  var _isControllerReady = false;

  //initial location (Munich) required for the map
  double _latitude = 48.137154;
  double _longitude = 11.576124;

  @override
  void initState() {
    //snapshot of the current data
    _driversList = Provider.of<DriversProvider>(context, listen: false).data;

    //prepare list of drivers names for the dropdown button
    for (var driver in _driversList) {
      _driversNames.add(driver.driverName);
    }
    _driversNames.sort();
    _selectedDriver =
        widget.driverName == '' ? _driversNames[_index] : widget.driverName;

    //update data every 5 seconds
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      Provider.of<DriversProvider>(context, listen: false)
          .fetchDriversData()
          .then((value) => setState(() {
                _latitude = _driversList[_index].location[0];
                _longitude = _driversList[_index].location[1];
              }));
    });

    super.initState();
  }

  //release memory when this object is removed
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //method to update and animate map camera position
  Future<void> moveCamera() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: driverLocation, zoom: 8, tilt: 80)));
  }

  Future<void> _updateDriver(var newName) async {
    _index = _driversList.indexWhere((driver) => driver.driverName == newName);
    _latitude = double.parse(_driversList[_index].location[0]);
    _longitude = double.parse(_driversList[_index].location[1]);

    moveCamera();
  }

  @override
  Widget build(BuildContext context) {
    //access the fetched data
    _driversList = Provider.of<DriversProvider>(context).data;

    //update driver location
    driverLocation = LatLng(_latitude, _longitude);
    if (_isControllerReady) moveCamera();

    return Stack(
      children: [
        mapWidget(),
        if (_driversNames.isNotEmpty) dropdownButton(),
      ],
    );
  }

  // ********** WIDGETS ********** //

  //Widget of the map
  Widget mapWidget() {
    final List<Marker> _markers = <Marker>[];
    _markers.add(Marker(
      markerId: MarkerId(_index.toString()),
      position: driverLocation,
      infoWindow: InfoWindow(
        title: _selectedDriver,
      ),
    ));

    return GoogleMap(
      markers: Set<Marker>.of(_markers),
      initialCameraPosition: CameraPosition(target: driverLocation, zoom: 9),
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        //take the controller from the function and assign to the State variable
        _controller = controller;
        _isControllerReady = true;
      },
    );
  }

  //Widget of the dropdown button
  Widget dropdownButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(),
            hint: const Text('Select driver '),
            icon: const Icon(Icons.keyboard_arrow_down),
            // The list of options
            items: _driversNames
                .map((items) => DropdownMenuItem(
                      child: Text(
                        items,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      value: items,
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedDriver = newValue;
                _updateDriver(newValue);
              });
            },
            value: _selectedDriver,
          ),
        ),
      ),
    );
  }
}
