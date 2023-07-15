import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(TrackLocation());
}

class TrackLocation extends StatefulWidget {
  @override
  _TrackLocationState createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your bus location'),
          backgroundColor: Color(0xFF070A52),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(13.067439, 80.237617),
            zoom: 15,
          ),
          onMapCreated: (controller) => _controller = controller,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _updateCameraPosition(37.7749, -122.4194),
          child: Icon(Icons.location_searching),
          backgroundColor: Color(0xFF070A52),
        ),
      ),
    );
  }

  void _updateCameraPosition(double? latitude, double? longitude) {
    if (latitude != null && longitude != null && _controller != null) {
      final newCameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      );
      _controller!
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }
}
