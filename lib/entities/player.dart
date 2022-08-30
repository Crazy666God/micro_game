import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:micro_game/entities/entity.dart';

class Player extends Entity {
  // Player(super.x, super.y, super.spriteName) {}
  Player() : super(50, 100, 'Icon');
  
  int icons = 0;
  
  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: visible ? sprites[icons] : SizedBox(),
    );
  }

  @override
  void move() {
    if (++x > 400) {
      if(++icons >= 2) icons = 0;
      x = 50;
    }
  }

  @override
  void update() {
    move();
  }
}
