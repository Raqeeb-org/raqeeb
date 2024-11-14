import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class TrackBusesScreen extends StatefulWidget {
  @override
  _TrackBusesScreenState createState() => _TrackBusesScreenState();
}

class _TrackBusesScreenState extends State<TrackBusesScreen> {
  Completer<GoogleMapController> _controller = Completer();

  // List of bus locations (initial coordinates)
  List<Map<String, dynamic>> buses = [
    {"id": "Bus 1", "latitude": 24.774265, "longitude": 46.738586},
    {"id": "Bus 2", "latitude": 24.774965, "longitude": 46.739586},
    {"id": "Bus 3", "latitude": 24.775265, "longitude": 46.740586},
    {"id": "Bus 4", "latitude": 24.775565, "longitude": 46.741586},
    {"id": "Bus 5", "latitude": 24.775865, "longitude": 46.742586},
  ];

  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadBusMarkers();
  }

  void _loadBusMarkers() {
    setState(() {
      for (var bus in buses) {
        final marker = Marker(
          markerId: MarkerId(bus['id']),
          position: LatLng(bus['latitude'], bus['longitude']),
          infoWindow: InfoWindow(
            title: bus['id'],
            snippet: "Location: (${bus['latitude']}, ${bus['longitude']})",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
        _markers[bus['id']] = marker;
      }
    });
  }

  Future<void> _updateBusLocations() async {
    setState(() {
      for (var bus in buses) {
        bus['latitude'] += 0.0001;
        bus['longitude'] += 0.0001;
        _markers[bus['id']] = Marker(
          markerId: MarkerId(bus['id']),
          position: LatLng(bus['latitude'], bus['longitude']),
          infoWindow: InfoWindow(
            title: bus['id'],
            snippet: "Updated Location: (${bus['latitude']}, ${bus['longitude']})",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_bus, // Bus icon
              color: const Color.fromARGB(255, 26, 0, 0),
            ),
            SizedBox(width: 8), // Space between icon and title
            Text("Buses Location"),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(24.774265, 46.738586),
          zoom: 14.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0), // Adjusts the button position
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: _updateBusLocations,
            backgroundColor: Colors.green,
            child: Icon(Icons.refresh),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TrackBusesScreen(),
  ));
}
