import 'dart:math';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/entity.dart';
import 'package:micro_game/utilits/global_vars.dart';

class Player extends Entity {
  double _angle = 0;
  double _degree = 0;
  bool isMoveLeft = false;
  bool isMoveRight = false;
  final double _speed = 3;
  bool isAcceleration = false;

  Player({required super.spriteName, required super.numberSprites})
      : super(x: 100, y: 100);

  get getAbgle => _angle;

  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: visible
          ? Transform.rotate(
              angle: _angle,
              child: sprites[currentSprite],
            )
          : const SizedBox(),
    );
  }

  @override
  void move() {
    if (!isAcceleration) return;
    if (isMoveLeft) _degree -= 5;
    if (isMoveRight) _degree += 5;

    _angle = _degree * 3.14 / 180;

    x += sin(_degree * 0.0175) * _speed;
    y -= cos(_degree * 0.0175) * _speed;

    if (x < 0) x = 0;
    if (y < 0) y = 0;
    if (x > GlobalVars.screenWidth - 100) x = GlobalVars.screenWidth - 100;
    if (y > GlobalVars.screenHeiht - 100) y = GlobalVars.screenHeiht - 100;

    isMoveLeft = false;
    isMoveRight = false;
  }
}
