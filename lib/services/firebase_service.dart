import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/structs/todo.dart';

class FirebaseService {
  static final FirebaseService _firebaseService = FirebaseService._internal();
  final collection = "todos";

  factory FirebaseService() {
    return _firebaseService;
  }

  FirebaseService._internal();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<void> uploadFile(String path, String name, String data) async {
    final ref = storage.ref(path).child(name);
    await ref.putString(data);
  }

  Future<String> downloadFile(String path, String name) async {
    final ref = storage.ref(path).child(name);
    final url = await ref.getDownloadURL();
    return url;
  }

  Future<String> addDocument(String path, ToDo data) async {
    final ref = firestore.collection(collection);
    var docRef = await ref.add({
      "topic": data.topic,
      "desc": data.desc,
      "complete": data.complete,
      "location": data.location,
      "time": data.time,
      "dateCompletion": data.dateCompletion,
      "files": data.files,
    });

    return docRef.id;
  }

  Future<void> updateDocument(String path, ToDo data) async {
    final ref = firestore.collection(collection);
    await ref.doc(path).update({
      "topic": data.topic,
      "desc": data.desc,
      "complete": data.complete,
      "location": data.location,
      "time": data.time,
      "dateCompletion": data.dateCompletion,
      "files": data.files,
    });
  }

  Future<List<ToDo>> getDocuments() async {
    final ref = firestore.collection(collection);
    final snapshot = await ref.get();
    final docs = snapshot.docs;
    final todos = docs
        .map((e) => ToDo(
            topic: e.data()["topic"],
            desc: e.data()["desc"],
            complete: e.data()["complete"],
            location: e.data()["location"],
            time: e.data()["time"],
            dateCompletion: e.data()["dateCompletion"],
            files: e.data()["files"]))
        .toList();
    return todos;
  }
}
