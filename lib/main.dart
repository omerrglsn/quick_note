import 'package:flutter/material.dart';
import 'package:hive_and_provider/common/theme.dart';
import 'package:hive_and_provider/constants/strings.dart';
import 'package:hive_and_provider/model/tasks.dart';
import 'package:hive_and_provider/screen/home_page.dart';
import 'package:hive_and_provider/viewmodel/home_page_viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>(taskBox);

  runApp(ListenableProvider(
    create: (context) => HomePageViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
