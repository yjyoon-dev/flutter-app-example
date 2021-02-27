import 'package:flutter/material.dart';

class Animal {
  String imagePath;
  String name;
  String kind;
  bool canFly = false;

  Animal(
      {@required this.name,
      @required this.kind,
      @required this.imagePath,
      this.canFly});
}
