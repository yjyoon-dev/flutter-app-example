import 'package:flutter/material.dart';
import 'package:flutter_app_example/todoThirdDetail.dart';
import 'todoSubDetail.dart';
import 'todoSecondDetail.dart';

class Todo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Todo();
}

class _Todo extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo', initialRoute: '/', routes: {
      '/': (context) => TodoSubDetail(),
      '/second': (context) => TodoSecondDetail(),
      '/third': (context) => TodoThirdDetail()
    });
  }
}
