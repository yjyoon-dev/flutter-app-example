import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileIO extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FileIO();
  }
}

class _FileIO extends State<FileIO> {
  List<String> itemList = new List();
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var result = await readItemList();
    setState(() {
      itemList.addAll(result);
    });
  }

  Future<List<String>> readItemList() async {
    var key = 'first';
    List<String> ret = new List();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool checkFirst = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruits.txt').exists();

    var file;

    // 앱 최초 실행 시 repo/fruit.txt 의 내용을 내부 저장소의
    // fruit.txt 파일에 똑같이 복사하여 사용할 것
    if (checkFirst == null || !checkFirst || !fileExist) {
      pref.setBool(key, true);
      file = await DefaultAssetBundle.of(context).loadString('repo/fruits.txt');
      File(dir.path + '/fruits.txt').writeAsStringSync(file);
    } else {
      file = await File(dir.path + '/fruits.txt').readAsString();
    }
    var array = file.split('\n');
    for (var item in array) {
      ret.add(item);
    }
    return ret;
  }

  void writeItem(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruits.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '/fruits.txt').writeAsStringSync(file);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File IO Example')),
      body: Container(
        child: Center(
          child: Column(children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text(
                        itemList[index],
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                },
                itemCount: itemList.length,
              ),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeItem(controller.value.text);
          setState(() {
            itemList.add(controller.value.text);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
