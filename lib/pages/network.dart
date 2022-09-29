import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile/components/custombar.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:mobile/services/service_locator.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  NetworkPageState createState() => NetworkPageState();
}

class NetworkPageState extends State<NetworkPage> {
  late StreamSubscription<ConnectivityResult> subscription;

  NotificationService notificationService = getIt<NotificationService>();

  var type = 'Unknown';

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        switch (result) {
          case ConnectivityResult.wifi:
            type = "Wi-Fi";
            break;
          case ConnectivityResult.mobile:
            type = "Sim";
            break;
          case ConnectivityResult.none:
            notificationService.showNotification(
                "Вы отключились от сети", "Уведомление");
            type = "-";
            break;
          case ConnectivityResult.ethernet:
            type = "Кабель";
            break;
          case ConnectivityResult.bluetooth:
            type = "Bluetooth";
            break;
          default:
        }
      });
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Сеть"),
      body: Center(
        child: Text("Тип подключения: $type"),
      ),
    );
  }
}
