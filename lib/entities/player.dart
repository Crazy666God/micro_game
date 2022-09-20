import 'dart:math';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/entity.dart';
import 'package:micro_game/point.dart';
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
      required super.spriteNumber,
      })
      : super(coordinates: Point(GlobalVars.screenWidth / 2, GlobalVars.screenHeiht / 2), spriteSize: const Size(98 / 2, 75 / 2));

  get getAngle => _angle;

  @override
  Widget build() {
    return Positioned(
      top: coordinates.x,
      left: coordinates.x,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: SizedBox(
          width: spriteSize.width,
          height: spriteSize.height,
          child: visible
              ? Transform.rotate(
                  alignment: Alignment.center,
                  angle: _angle,
                  child: sprite,
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

    coordinates.x += sin(_angle) * _speed;
    coordinates.y -= cos(_angle) * _speed;

    if (coordinates.x < spriteSize.width / 2) {
      coordinates.x = spriteSize.width / 2;
    }
    if (coordinates.y < spriteSize.height / 2) {
      coordinates.y = spriteSize.height / 2;
    }
    if (coordinates.x > GlobalVars.screenWidth - spriteSize.width / 2) {
      coordinates.x = GlobalVars.screenWidth - spriteSize.width / 2;
    }
    if (coordinates.y > GlobalVars.screenHeiht - spriteSize.height / 2) {
      coordinates.y = GlobalVars.screenHeiht - spriteSize.height / 2;
    }

    isMoveLeft = false;
    isMoveRight = false;
  }
}
