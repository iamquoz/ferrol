import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:mobile/components/button.dart';
import 'package:mobile/pages/camera.dart';
import 'package:mobile/pages/localtodos.dart';
import 'package:mobile/pages/maps.dart';
import 'package:mobile/pages/network.dart';
import 'package:mobile/pages/sensors.dart';
import 'package:mobile/pages/firebasetodos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.camera});
  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
            text: "Камера",
            page: CameraPage(camera: camera),
            icon: Icons.camera),
        const CustomButton(
            text: "Сеть", page: NetworkPage(), icon: Icons.network_check),
        const CustomButton(
            text: "Локальная БД",
            page: LocalToDoListPage(),
            icon: Icons.data_array),
        const CustomButton(
            text: "Удаленная БД",
            page: FirebaseToDoListPage(),
            icon: Icons.web),
        const CustomButton(
            text: "Датчики", page: SensorsPage(), icon: Icons.sensors),
        const CustomButton(text: "Карты", page: MapPage(), icon: Icons.map),
      ],
    );
  }
}
