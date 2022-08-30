import 'package:flutter/material.dart';

abstract class Entity {
  double x, y;
  String spriteName;
  bool visible = true;
  List sprites = [];

  Entity({required this.x, required this.y, required this.spriteName}) {
    sprites.add(
      Image.asset('assets/$spriteName.png'),
    );
  }

  void update();
  void move();
  Widget build();
}
