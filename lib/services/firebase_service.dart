import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/structs/todo.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseService {
  static final FirebaseService _firebaseService = FirebaseService._internal();
  final collection = "todos";

  factory FirebaseService() {
    return _firebaseService;
  }

  FirebaseService._internal();

  final firestore = FirebaseFirestore.instance;

  Future<String> addDocument(ToDo data) async {
    final ref = firestore.collection(collection);
    var docRef = await ref.add({
      "topic": data.title,
    });

    return docRef.id;
  }

  Future<void> deleteDocument(String id) async {
    final ref = firestore.collection(collection).doc(id);
    await ref.delete();
  }

  Future<void> updateDocument(String path, ToDo data) async {
    final ref = firestore.collection(collection);
    await ref.doc(path).update({
      "topic": data.title,
    });
  }

  Future<List<ToDo>> getDocuments() async {
    final ref = firestore.collection(collection);
    final snapshot = await ref.get();
    final docs = snapshot.docs;
    final todos =
        docs.map((e) => ToDo(id: e.id, title: e.data()["topic"])).toList();
    return todos;
  }

  void dumpToFile() async {
    final todos = await getDocuments();

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/firebase_todos.json');

    await file.writeAsString(jsonEncode(todos));
  }
}
