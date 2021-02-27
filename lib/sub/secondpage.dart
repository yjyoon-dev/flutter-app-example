import 'package:flutter/material.dart';
import '../animalItem.dart';

class Secondpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Secondpage();
  List<Animal> animalList;
  Secondpage({Key key, @required this.animalList}) : super(key: key);
}

class _Secondpage extends State<Secondpage> {
  final nameController = TextEditingController();
  int _radioValue = 0;
  bool canFly = false;
  String _imagePath;

  _radioChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('양서류'),
                  Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('파충류'),
                  Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('포유류'),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Row(
                children: [
                  Text('날 수 있음'),
                  Checkbox(
                    value: canFly,
                    onChanged: ((check) {
                      setState(
                        () {
                          canFly = check;
                        },
                      );
                    }),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        child: Image.asset('image/cow.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/cow.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/pig.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/pig.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/bee.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/bee.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/cat.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/cat.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/cow.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/cow.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/dog.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/dog.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/fox.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/fox.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/monkey.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/monkey.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/pig.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/pig.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/wolf.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/wolf.png';
                        },
                      ),
                    ],
                  )),
              RaisedButton(
                child: Text('동물 추가하기'),
                onPressed: () {
                  var animal = Animal(
                      name: nameController.value.text,
                      kind: getKind(_radioValue),
                      imagePath: _imagePath,
                      canFly: canFly);
                  AlertDialog dialog = AlertDialog(
                    title: Text('동물 추가'),
                    content:
                        Text('${animal.name}(${animal.kind})을(를) 추가하시겠습니까?)'),
                    actions: [
                      RaisedButton(
                        onPressed: () {
                          widget.animalList.add(animal);
                          Navigator.of(context).pop();
                        },
                        child: Text("예"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("아니오"),
                      ),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}
