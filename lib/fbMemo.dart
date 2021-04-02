import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';
import 'addMemo.dart';
import 'memoDetail.dart';

class FBMemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FBMemo();
}

class _FBMemo extends State<FBMemo> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _datebaseURL =
      'https://flutter-firebase-example-5874b-default-rtdb.firebaseio.com/';
  List<Memo> memos = List();

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _datebaseURL);
    reference = _database.reference().child('memo');

    reference.onChildAdded.listen((event) {
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Memo App')),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: SizedBox(
                              child: GestureDetector(
                                onTap: () async {
                                  Memo memo = await Navigator.of(context).push(
                                      MaterialPageRoute<Memo>(
                                          builder: (context) => MemoDetail(
                                              reference, memos[index])));
                                  if (memo != null) {
                                    setState(() {
                                      memos[index].title = memo.title;
                                      memos[index].content = memo.content;
                                    });
                                  }
                                },
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(memos[index].title),
                                          content: Text('메모를 삭제하시겠습니까?'),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  reference
                                                      .child(memos[index].key)
                                                      .remove()
                                                      .then((value) {
                                                    setState(() {
                                                      memos.removeAt(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  });
                                                },
                                                child: Text('예')),
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text('아니오'))
                                          ],
                                        );
                                      });
                                },
                                child: Text(memos[index].content),
                              ),
                            )),
                        header: Text(memos[index].title),
                        footer: Text(memos[index].createTime.substring(0, 10)),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddMemo(reference)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
