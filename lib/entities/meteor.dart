import 'dart:math';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/entity.dart';
import 'package:micro_game/utilits/global_vars.dart';

class Meteor extends Entity {
  final double _speed = 3;
  final int angle;
  double _rotationAngle = 0;

  Meteor({
    required this.angle, 
    required super.coordinates,
    required super.spriteName,
    required super.spriteNumber,
    required super.spriteSize,
  });

  @override
  Image setSprite() {
    return Image.asset('assets/meteors/${spriteName}_$spriteNumber.png');
  }

  @override
  Widget build() {
    return Positioned(
      top: coordinates.y,
      left: coordinates.x,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: SizedBox(
          width: spriteSize.width,
          height: spriteSize.height,
          child: visible
              ? Transform.rotate(
                  alignment: Alignment.center,
                  angle: _rotationAngle,
                  child: sprite,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  @override
  void move() {
    _rotationAngle += 0.025;
    coordinates.x += sin(angle * 0.0175) * _speed;
    coordinates.y -= cos(angle * 0.0175) * _speed;
    if (coordinates.x > GlobalVars.screenWidth + 200 ||
        coordinates.y > GlobalVars.screenHeiht + 200 ||
        coordinates.x < -200 ||
        coordinates.y < -200) {
      visible = false;
    }
  }
}
