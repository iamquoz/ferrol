import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String topic;
  String desc;
  bool complete = false;
  GeoPoint location;
  Timestamp time;
  Timestamp dateCompletion;
  List<dynamic> files;

  ToDo(
      {required this.topic,
      required this.desc,
      required this.location,
      required this.time,
      required this.dateCompletion,
      required this.files,
      this.complete = false});
}
