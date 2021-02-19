import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageWidget();
  }
}

class _ImageWidget extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Widget'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/flutter_logo.png', width: 200, height: 100),
              Text(
                'Flutter',
                style: TextStyle(
                    fontFamily: 'Jost', fontSize: 30, color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
