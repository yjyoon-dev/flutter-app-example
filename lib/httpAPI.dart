import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class HttpApi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpApi();
}

class _HttpApi extends State<HttpApi> {
  String result = "";
  List data;
  TextEditingController _editingController;
  ScrollController _scrollController;
  int page;

  @override
  void initState() {
    super.initState();
    data = new List();
    _editingController = new TextEditingController();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      print('offset = ${_scrollController.offset}');
      print('max = ${_scrollController.position.maxScrollExtent}');
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent - 2 &&
          !_scrollController.position.outOfRange) {
        page++;
        getJSONData();
      }
    });

    page = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요.'),
        ),
      ),
      body: Container(
        child: Center(
          child: data.isEmpty
              ? Text(
                  '검색 결과가 없습니다.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        child: Container(
                          child: Row(
                            children: [
                              Image.network(
                                data[index]['thumbnail'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          data[index]['title'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(data[index]['authors'].toString()),
                                        Text(data[index]['sale_price']
                                            .toString()),
                                        Text(data[index]['status'].toString()),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        onTap: () {
                          _launchURL(data[index]['url']);
                        },
                      ),
                    );
                  },
                  itemCount: data.length,
                  controller: _scrollController,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page = 1;
          data.clear();
          getJSONData();
        },
        child: Icon(Icons.search),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url =
        'https://dapi.kakao.com/v3/search/book?target=title&query=${_editingController.value.text}&page=${page}';
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "KakaoAK b53ed51a4f0fd8dc6dfed177121c29aa"});
    setState(() {
      var jsonData = json.decode(response.body);
      List result = jsonData['documents'];
      data.addAll(result);
    });
    return response.body;
  }

  void _launchURL(String url) async {
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      AlertDialog dialog = AlertDialog(
          content: Text(
        '해당 도서의 링크가 존재하지 않습니다!',
      ));
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
  }
}
