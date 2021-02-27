import 'package:flutter/material.dart';
import 'animalItem.dart';
import 'sub/firstpage.dart';
import 'sub/secondpage.dart';

class Tabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Tabbar();
  }
}

class _Tabbar extends State<Tabbar> {
  List<Animal> animalList = List();

  void initState() {
    super.initState();

    animalList.add(Animal(
      imagePath: "image/bee.png",
      name: "벌",
      kind: "곤충",
    ));
    animalList.add(Animal(
      imagePath: "image/cat.png",
      name: "고양이",
      kind: "포유류",
    ));
    animalList.add(Animal(
      imagePath: "image/cow.png",
      name: "젖소",
      kind: "포유류",
    ));
    animalList.add(Animal(
      imagePath: "image/dog.png",
      name: "강아지",
      kind: "포유류",
    ));
    animalList.add(Animal(
      imagePath: "image/fox.png",
      name: "여우",
      kind: "포유류",
    ));
    animalList.add(Animal(
      imagePath: "image/monkey.png",
      name: "원숭이",
      kind: "영장류",
    ));
    animalList.add(Animal(
      imagePath: "image/pig.png",
      name: "돼지",
      kind: "포유류",
    ));
    animalList.add(Animal(
      imagePath: "image/wolf.png",
      name: "늑대",
      kind: "포유류",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar & ListView'),
        ),
        body: TabBarView(
          children: [
            Firstpage(
              animalList: animalList,
            ),
            Secondpage(
              animalList: animalList,
            ),
          ],
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
