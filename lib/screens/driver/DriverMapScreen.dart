import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:raqeeb/screens/commons/location_service.dart';

class DriverMapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> studentLocations; // List of student locations

  DriverMapScreen({required this.studentLocations});

  @override
  _DriverMapScreenState createState() => _DriverMapScreenState();
}

class _DriverMapScreenState extends State<DriverMapScreen> {
  GoogleMapController? _mapController;
  Marker? _driverMarker;
  Set<Marker> _studentMarkers = {};
  late Stream<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _positionStream = LocationService().getDriverLocation(); // Start the location stream
    _createStudentMarkers(); // Create markers for each student location
  }

  void _createStudentMarkers() {
    for (var student in widget.studentLocations) {
      _studentMarkers.add(
        Marker(
          markerId: MarkerId(student['name']),
          position: LatLng(student['latitude'], student['longitude']),
          infoWindow: InfoWindow(title: student['name']),
        ),
      );
    }
  }

  void _updateDriverLocation(Position position) {
    LatLng newLocation = LatLng(position.latitude, position.longitude);
    setState(() {
      _driverMarker = Marker(
        markerId: MarkerId("driver"),
        position: newLocation,
        infoWindow: InfoWindow(title: "Driver's Location"),
      );
    });
    _mapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Map"),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: StreamBuilder<Position>(
        stream: _positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Instead of calling setState directly, call _updateDriverLocation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateDriverLocation(snapshot.data!);
            });
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(24.7136, 46.6753), // Initial location (e.g., Riyadh)
              zoom: 12,
            ),
            markers: _driverMarker != null
                ? _studentMarkers.union({_driverMarker!})
                : _studentMarkers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          );
        },
      ),
    );
  }
}
