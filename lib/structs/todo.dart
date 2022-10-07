import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 5)
class ToDo {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;

  ToDo({
    this.id = "",
    required this.title,
  });

  Map toJson() => {
        "id": id,
        "title": title,
      };
}
