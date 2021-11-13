import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Marker driverLocation;
  //To update the map according to our needs
  late GoogleMapController _controller;
  final List<Marker> _markers = <Marker>[];

  double initLat = 48.137154;
  double initLng = 11.576124;
  late Timer timer;

  //initiate periodic updater
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        initLat += 0.001;
        initLng += 0.001;
      });
    });
  }

  //clean memory
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng driverPos = LatLng(initLat, initLng);

    var _initialCameraPosition = CameraPosition(
      target: driverPos,
      zoom: 13,
    );

    _markers.add(Marker(
      markerId: MarkerId('id'),
      position: driverPos,
      infoWindow: InfoWindow(title: 'Driver location', snippet: 'Driver data'),
    ));

    //update and animate camera position
    Future<void> moveCamera() async {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: driverPos, zoom: 13)));
    }

    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          //take the controller from the function and assign to the State variable
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveCamera,
        backgroundColor: Colors.lightBlue,
        tooltip: 'reposition',
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
