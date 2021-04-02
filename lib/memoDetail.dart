import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'memo.dart';

class MemoDetail extends StatefulWidget {
  final DatabaseReference reference;
  final Memo memo;

  MemoDetail(this.reference, this.memo);

  @override
  State<StatefulWidget> createState() => _MemoDetail();
}

class _MemoDetail extends State<MemoDetail> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.memo.title),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
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
                  Memo memo = Memo(titleController.value.text,
                      contentController.value.text, widget.memo.createTime);
                  widget.reference
                      .child(widget.memo.key)
                      .set(memo.toJson())
                      .then((value) => Navigator.of(context).pop(memo));
                },
                child: Text('수정하기'),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              )
            ]),
          ),
        ));
  }
}
