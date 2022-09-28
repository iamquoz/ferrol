import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/custombar.dart';

import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(camera: cameras.first));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(title: "Мобильные приложения"),
        body: HomePage(camera: camera),
      ),
    );
  }
}
