import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  Map<String, String> _iconMap = {
    '더하기': '+',
    '빼기': '-',
    '곱하기': '*',
    '나누기': '/'
  };
  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List();
  String _buttonText;

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text('결과: $sum', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: RaisedButton(
                child: Row(
                  children: [
                    Text(_iconMap[_buttonText]),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(_buttonText),
                    )
                  ],
                ),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    double num1 = double.parse(value1.value.text);
                    double num2 = double.parse(value2.value.text);
                    double res;
                    switch (_buttonText) {
                      case '더하기':
                        res = num1 + num2;
                        break;
                      case '빼기':
                        res = num1 - num2;
                        break;
                      case '곱하기':
                        res = num1 * num2;
                        break;
                      case '나누기':
                        res = num1 / num2;
                        break;
                    }
                    sum = '$res';
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  items: _dropDownMenuItems,
                  value: _buttonText,
                  onChanged: (value) {
                    setState(() {
                      _buttonText = value;
                    });
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
