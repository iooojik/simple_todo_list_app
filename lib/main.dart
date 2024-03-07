import 'package:flutter/material.dart';
import 'package:next_step_app/views/pages/main/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Next Step',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainView.create());
  }
}
