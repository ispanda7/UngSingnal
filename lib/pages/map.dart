import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ungsingal/utility/my_style.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  double lat, lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData data = await findLocationData();
    setState(() {
      lat = data.latitude;
      lng = data.longitude;
      print('($lat, $lng)');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lat == null ? MyStyle().showProgress() : buildMap(),
    );
  }

  Set<Marker> mySet() {
    return <Marker>[
      Marker(
        markerId: MarkerId('idYou'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'You are Here ?', snippet: 'lat = $lat, lng = $lng'),
      ),
    ].toSet();
  }

  Widget buildMap() => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mySet(),
      );
}
