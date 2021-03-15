import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SharedPref();
  }
}

class _SharedPref extends State<SharedPref> {
  int _num = 0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _setData(int value) async {
    var key = 'num';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  void _getData() async {
    var key = 'num';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getInt(key);
      if (value != null) _num = value;
    });
  }

  void _increaseData() {
    setState(() {
      _setData(++_num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences Example')),
      body: Center(
        child: Text(
          '$_num',
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increaseData,
        child: Icon(Icons.add),
      ),
    );
  }
}
