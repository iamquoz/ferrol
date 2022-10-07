import 'package:flutter/material.dart';
import 'package:mobile/components/custombar.dart';
import 'package:mobile/services/firebase_service.dart';
import 'package:mobile/services/service_locator.dart';
import 'package:mobile/structs/todo.dart';

class FirebaseToDoListPage extends StatefulWidget {
  const FirebaseToDoListPage({super.key});

  @override
  FirebaseToDoListPageState createState() => FirebaseToDoListPageState();
}

class FirebaseToDoListPageState extends State<FirebaseToDoListPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  List<ToDo> _toDoList = [];

  FirebaseService firebaseService = getIt<FirebaseService>();

  Future<List<ToDo>> getToDos() async {
    _toDoList = await firebaseService.getDocuments();
    return _toDoList;
  }

  @override
  void initState() {
    firebaseService.getDocuments().then((value) => setState(() {
          _toDoList.addAll(value);
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6d6d6),
      appBar: CustomAppBar(
          title: "Список дел", onInvoke: () => firebaseService.dumpToFile()),
      body: FutureBuilder<List<ToDo>>(
        future: getToDos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _toDoList.isEmpty
                ? const Center(child: Text("Список пуст"))
                : ListView.builder(
                    itemCount: _toDoList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(color: const Color(0xfff1a13f)),
                        key: Key(_toDoList[index].id),
                        onDismissed: (direction) => setState(() {
                          firebaseService.deleteDocument(_toDoList[index].id);
                          _toDoList.removeAt(index);
                        }),
                        child: ListTile(
                          title: Text(_toDoList[index].title),
                        ),
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            return const Text("Ошибка подключения к интернету");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfff1a13f),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Добавить дело"),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите название дела";
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          var toDo = ToDo(
                            title: _controller.text,
                          );
                          firebaseService.addDocument(toDo);
                          _toDoList.add(toDo);
                          _controller.clear();
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Добавить"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Отмена"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
