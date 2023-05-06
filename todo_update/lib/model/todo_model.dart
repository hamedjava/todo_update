import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? title;
  TodoModel({this.title, this.date});
}
