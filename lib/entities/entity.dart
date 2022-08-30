import 'package:flutter/material.dart';

abstract class Entity {
  double x, y;
  String spriteName;
  bool visible = true;
  List sprites = [];

  Entity(this.x, this.y, this.spriteName) {
    for (int i = 0; i < 4; ++i) {
      sprites.add(Image.asset('assets/$spriteName$i.png'));
    }
  }

  void update();
  void move();
  Widget build();
}
