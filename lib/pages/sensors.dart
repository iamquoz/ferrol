import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/components/custombar.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  SensorsPageState createState() => SensorsPageState();
}

class SensorsPageState extends State<SensorsPage> {
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  AccelerometerEvent _accelerometerEvent = AccelerometerEvent(0, 0, 0);

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6d6d6),
      appBar: const CustomAppBar(title: "Датчики"),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Аккселерометр"),
          Text("x: ${_accelerometerEvent.x}"),
          Text("y: ${_accelerometerEvent.y}"),
          Text("z: ${_accelerometerEvent.z}"),
        ],
      )),
    );
  }
}
