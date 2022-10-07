import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/structs/todo.dart';
import 'package:path_provider/path_provider.dart';

class LocalDbService {
  static final LocalDbService _localDbService = LocalDbService._internal();
  final collection = "todos";

  late Box<ToDo> box;

  factory LocalDbService() {
    return _localDbService;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ToDoAdapter());
    box = await Hive.openBox<ToDo>(collection);
  }

  LocalDbService._internal();

  Future<String> addDocument(ToDo data) async {
    var id = idGenerator();
    data.id = id;
    box.put(id, data);
    return id;
  }

  Future<void> deleteDocument(String id) async {
    box.delete(id);
  }

  Future<void> updateDocument(String path, ToDo data) async {
    box.put(path, data);
  }

  Future<List<ToDo>> getDocuments() async {
    final todos = box.values.toList();
    return todos;
  }

  void dumpToFile() async {
    final todos = await getDocuments();

    // writes to /storage/0/emulated/0/Android/data/com.example.mobile/files
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/local_todos.json');

    await file.writeAsString(jsonEncode(todos));
  }

  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}
