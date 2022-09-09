import 'dart:math';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/entity.dart';
import 'package:micro_game/utilits/global_vars.dart';

class Bullet extends Entity {
  final double playerAngle;
  final double _speed = 6; 

  Bullet({
    required this.playerAngle,
    required super.x,
    required super.y,
    required super.spriteName,
    required super.numberSprites,
    super.spriteSize = const Size(13, 57),
  });

  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: SizedBox(
          width: spriteSize.width / 2,
          height: spriteSize.height / 2,
          child: Transform.rotate(
            angle: playerAngle,
            child: sprites[currentSprite],
          ),
        ),
      ),
    );
  }

  @override
  void move() {
    x += sin(playerAngle) * _speed;
    y -= cos(playerAngle) * _speed;
    if (x > GlobalVars.screenWidth ||
        y > GlobalVars.screenHeiht ||
        x < 0 ||
        y < -spriteSize.height) {
      visible = false;
    }
  }
}
