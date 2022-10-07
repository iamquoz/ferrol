import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:mobile/components/custombar.dart';
import 'package:mobile/services/location_service.dart';
import 'package:mobile/services/service_locator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  LocationService locationService = getIt<LocationService>();

  @override
  void initState() {
    super.initState();
    locationService.getPosition().then((value) {
      if (mounted) {
        setState(() {
          latitude = value.latitude;
          longitude = value.longitude;
          mapController.move(LatLng(latitude, longitude), 15);
        });
      }
    }).catchError((error) => print(error));
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  late double latitude = 0.0;
  late double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6d6d6),
      appBar: const CustomAppBar(title: "Карты"),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(latitude, longitude),
          zoom: 3,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}
