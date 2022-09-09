import 'package:hive_flutter/hive_flutter.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String note;

  Tasks({
    required this.title,
    required this.note,
  });
}
