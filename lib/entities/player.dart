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

  Player(
      {required super.spriteName,
      required super.numberSprites,
      super.spriteSize = const Size(98 / 2, 75 / 2)})
      : super(x: GlobalVars.screenWidth / 2, y: GlobalVars.screenHeiht / 2);

  get getAngle => _angle;

  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: SizedBox(
          width: spriteSize.width,
          height: spriteSize.height,
          child: visible
              ? Transform.rotate(
                  alignment: Alignment.center,
                  angle: _angle,
                  child: sprites[currentSprite],
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  @override
  void move() {
    if (!isAcceleration) return;
    if (isMoveLeft) _degree -= 5;
    if (isMoveRight) _degree += 5;

    _angle = _degree * 0.0175; // 3.14 / 180 = 0.0175;

    x += sin(_angle) * _speed;
    y -= cos(_angle) * _speed;

    if (x < spriteSize.width / 2) {
      x = spriteSize.width / 2;
    }
    if (y < spriteSize.height / 2) {
      y = spriteSize.height / 2;
    }
    if (x > GlobalVars.screenWidth - spriteSize.width / 2) {
      x = GlobalVars.screenWidth - spriteSize.width / 2;
    }
    if (y > GlobalVars.screenHeiht - spriteSize.height / 2) {
      y = GlobalVars.screenHeiht - spriteSize.height / 2;
    }

    isMoveLeft = false;
    isMoveRight = false;
  }
}
