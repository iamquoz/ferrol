import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:mobile/components/button.dart';
import 'package:mobile/pages/camera.dart';
import 'package:mobile/pages/maps.dart';
import 'package:mobile/pages/network.dart';
import 'package:mobile/pages/sensors.dart';
import 'package:mobile/pages/todos.dart';

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
            icon: Icons.camera,
            color: const Color(0xffe91e63)),
        const CustomButton(
            text: "Сеть",
            page: NetworkPage(),
            icon: Icons.network_check,
            color: Color(0xff2196f3)),
        CustomButton(
            text: "Локальная БД",
            page: CameraPage(camera: camera),
            icon: Icons.data_array,
            color: const Color(0xFF589636)),
        CustomButton(
            text: "Удаленная БД",
            page: ToDoListPage(),
            icon: Icons.web,
            color: const Color(0xFFFFCA28)),
        const CustomButton(
            text: "Датчики",
            page: SensorsPage(),
            icon: Icons.sensors,
            color: Color(0xFFE53935)),
        const CustomButton(
            text: "Карты",
            page: MapPage(),
            icon: Icons.map,
            color: Color(0xFF1E88E5)),
      ],
    );
  }
}
