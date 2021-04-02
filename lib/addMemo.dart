import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';

class AddMemo extends StatefulWidget {
  final DatabaseReference reference;

  AddMemo(this.reference);

  @override
  State<StatefulWidget> createState() => _AddMemo();
}

class _AddMemo extends State<AddMemo> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Memo'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: '제목', fillColor: Colors.blueAccent),
                ),
                Expanded(
                    child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(labelText: '내용'),
                )),
                FlatButton(
                    onPressed: () {
                      widget.reference
                          .push()
                          .set(Memo(
                                  titleController.value.text,
                                  contentController.value.text,
                                  DateTime.now().toIso8601String())
                              .toJson())
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: Text('저장하기'),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1)))
              ],
            ),
          ),
        ));
  }
}
