import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_update/model/todo_model.dart';
import 'package:todo_update/routes/MyRoutes.dart';
import 'package:todo_update/view/splash.dart';

void main() async {
  await Hive.initFlutter("todoDB");
  Hive.registerAdapter(TodoModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: MyRoutes.routes,
      home: const Splash(),
    );
  }
}
