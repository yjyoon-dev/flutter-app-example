import 'package:flutter/material.dart';
import 'imageWidget.dart';
import 'calculator.dart';
import 'tabbar.dart';
import 'httpAPI.dart';
import 'largeFileDown.dart';
import 'todo.dart';
import 'sharedpref.dart';
import 'fileio.dart';
import 'introPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IntroPage());
  }
}

class MaterialFlutterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterialFlutterApp();
  }
}

class _MaterialFlutterApp extends State<MaterialFlutterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Flutter App'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LargeFileDown()));
            },
            child: Text(
              '로고 바꾸기',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
