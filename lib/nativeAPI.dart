import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class NativeAPI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NativeAPI();
}

class _NativeAPI extends State<NativeAPI> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  String _deviceInfo = 'Unknown info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native 통신 예제'),
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info: ${e.message}.';
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }
}
