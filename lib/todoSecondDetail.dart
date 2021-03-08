import 'package:flutter/material.dart';

class TodoSecondDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoSecondDetail();
}

class _TodoSecondDetail extends State<TodoSecondDetail> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add List'),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.value.text);
                },
                child: Text('추가하기'))
          ],
        )),
      ),
    );
  }
}
