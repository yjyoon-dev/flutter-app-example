import 'package:flutter/material.dart';
import '../animalItem.dart';

class Firstpage extends StatelessWidget {
  final List<Animal> animalList;
  Firstpage({Key key, this.animalList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, position) {
                return GestureDetector(
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          animalList[position].imagePath,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(animalList[position].name)
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertDialog dialog = AlertDialog(
                        content: Text(
                      '${animalList[position].kind}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ));
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },
                );
              },
              itemCount: animalList.length),
        ),
      ),
    );
  }
}
