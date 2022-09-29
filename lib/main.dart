import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/custombar.dart';
import 'package:mobile/services/firebase_service.dart';
import 'package:mobile/services/location_service.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/service_locator.dart';

import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseService();

  final cameras = await availableCameras();
  await NotificationService().init();
  LocationService();

  setup();
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
