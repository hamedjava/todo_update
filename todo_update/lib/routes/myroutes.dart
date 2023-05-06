import 'package:flutter/material.dart';
import 'package:todo_update/view/home.dart';
import 'package:todo_update/view/login.dart';
import 'package:todo_update/view/signup.dart';

class MyRoutes {
  static const String home = "/homepage";
  static const String login = "/login";
  static const String signup = "/signup";
  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const MyHomePage(title: "Welcome"),
    login: (context) => const Login(),
    signup: (context) => const Signup(),
  };
}
