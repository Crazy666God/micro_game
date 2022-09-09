import 'package:flutter/material.dart';

abstract class Entity {
  final Size spriteSize;
  double x, y;
  final String spriteName;
  bool visible = true;
  List<Image> sprites = [];
  int currentTick = 0;
  int currentSprite = 0;
  final int numberSprites;

  Entity(
      {required this.x,
      required this.y,
      required this.spriteName,
      required this.numberSprites,
      required this.spriteSize}) {
    for (int i = 0; i < numberSprites; ++i) {
      sprites.add(
        Image.asset('assets/$spriteName$i.png'),
      );
    }
  }

  void update() {
    _animation();
    move();
  }

  void move();

  void _animation() {
    if (++currentTick < 15) {
      currentSprite < numberSprites - 1 ? ++currentSprite : currentSprite = 0;
      currentTick = 0;
    }
  }

  Widget build();
}
