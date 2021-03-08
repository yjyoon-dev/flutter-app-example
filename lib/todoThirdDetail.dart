import 'package:flutter/material.dart';

class TodoThirdDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoThirdDetail();
}

class _TodoThirdDetail extends State<TodoThirdDetail> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: Container(
            child: Center(
                child: Text(
          args,
          style: TextStyle(fontSize: 30),
        ))));
  }
}
