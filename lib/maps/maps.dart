import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

double _originLatitude = 41.089994;
double _originLongitude = 28.948372;
double _destLatitude = 41.089994;
double _destLongitude = 28.948372;

class _MapsState extends State<Maps> {
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  MapType _currentMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 15,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: goToLoc,
        child: Icon(Icons.map),
      ),
      body: GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        markers: _cretaeMarker(),
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _initalCameraPosition,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Set<Marker> _cretaeMarker() {
    return <Marker>[
      Marker(
          infoWindow: InfoWindow(title: "Haliç Üniversitesi"),
          markerId: MarkerId("halic"),
          position: _initalCameraPosition.target,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
      Marker(
          infoWindow: InfoWindow(title: "Ev"),
          markerId: MarkerId("asdasdd"),
          position: LatLng(41.089994, 28.948372),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
      Marker(
          infoWindow: InfoWindow(title: "Haliç Üniversitesi 5.Levent Blokları"),
          markerId: MarkerId("asdsasdd"),
          position: LatLng(41.089994, 28.948372),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    ].toSet();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  goToLoc() async {
    final GoogleMapController mapController = await _controller.future;
    mapController
        .animateCamera(CameraUpdate.newLatLng(LatLng(41.089994, 28.948372)));
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCzFlbNYhBQBRb8zDQsrgVj0TazijIqlpA",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("Hata" + result.points.toString());
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}
