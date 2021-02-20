import 'package:flutter/material.dart';
import 'sub/firstpage.dart';
import 'sub/secondpage.dart';

class Tabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Tabbar();
  }
}

class _Tabbar extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabbar'),
        ),
        body: TabBarView(
          children: [Firstpage(), Secondpage()],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Tab>[
            Tab(
                icon: Icon(Icons.looks_one, color: Colors.blue),
                child: Text('First', style: TextStyle(color: Colors.blue))),
            Tab(
              icon: Icon(Icons.looks_two, color: Colors.blue),
              child: Text('Second', style: TextStyle(color: Colors.blue)),
            )
          ],
        ),
      ),
    );
  }
}
