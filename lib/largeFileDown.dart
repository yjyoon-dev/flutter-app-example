import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LargeFileDown();
}

class _LargeFileDown extends State<LargeFileDown> {
  bool downloading = false;
  var processString = "";
  var file;
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '이미지 주소를 입력해주세요.'),
        ),
      ),
      body: Center(
          child: downloading
              ? Container(
                  height: 120.0,
                  width: 200.0,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Now downloading... ${processString}',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print('none');
                        return Text('데이터 없음');
                      case ConnectionState.waiting:
                        print('waiting');
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                        print('active');
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        print('done');
                        if (snapshot.hasData) return snapshot.data;
                    }
                    return Text('다운로드 버튼을 눌러주세요');
                  },
                  future: downloadWidget(file),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio
          .download(_editingController.value.text, '${dir.path}/myimage.jpg',
              onReceiveProgress: (rec, total) {
        print('Rec: $rec, Total:$total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          processString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      AlertDialog dialog = AlertDialog(
          content: Text(
        '이미지 주소가 잘못되었습니다',
      ));
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
    setState(() {
      downloading = false;
      processString = "Completed";
    });
    print('Download Completed');
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if (exist) {
      return Center(
        child: Column(
          children: [Image.file(File(filePath))],
        ),
      );
    } else {
      return Text('NO Data');
    }
  }
}
