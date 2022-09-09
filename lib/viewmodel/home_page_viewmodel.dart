import 'package:flutter/material.dart';
import 'package:hive_and_provider/constants/strings.dart';
import 'package:hive_and_provider/model/tasks.dart';
import 'package:hive_flutter/adapters.dart';

class HomePageViewModel extends ChangeNotifier {
  final Box<Tasks> _box = Hive.box(taskBox);

  Box<Tasks> get box => _box;

  /// Add [task] to database.
  void add(Tasks tasks) {
    _box.add(tasks);
    notifyListeners();
  }

  /// Removes [task] from the database.
  void removeAt(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  /// Removes all tasks from the [database].
  void removeAll() {
    _box.clear();
    notifyListeners();
  }
}
