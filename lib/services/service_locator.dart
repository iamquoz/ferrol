import 'package:get_it/get_it.dart';
import 'package:mobile/services/firebase_service.dart';
import 'package:mobile/services/localdb_service.dart';
import 'package:mobile/services/location_service.dart';

import 'notification_service.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerSingleton<LocalDbService>(LocalDbService());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<LocationService>(LocationService());
  getIt.registerSingleton<FirebaseService>(FirebaseService());
}
