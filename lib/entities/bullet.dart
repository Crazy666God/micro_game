import 'dart:math';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/entity.dart';
import 'package:micro_game/utilits/global_vars.dart';

class Bullet extends Entity {
  final double playerAngle;
  final double _speed = 6; 

  Bullet({
    required this.playerAngle,
    required super.coordinates,
    required super.spriteName,
    required super.spriteNumber,
    super.spriteSize = const Size(13, 57),
  });

  @override
  Widget build() {
    return Positioned(
      top: coordinates.y,
      left: coordinates.x,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: SizedBox(
          width: spriteSize.width / 2,
          height: spriteSize.height / 2,
          child: Transform.rotate(
            angle: playerAngle,
            child: sprite,
          ),
        ),
      ),
    );
  }

  @override
  void move() {
    coordinates.x += sin(playerAngle) * _speed;
    coordinates.y -= cos(playerAngle) * _speed;
    if (coordinates.x > GlobalVars.screenWidth ||
        coordinates.y > GlobalVars.screenHeiht ||
        coordinates.x < 0 ||
        coordinates.y < -spriteSize.height) {
      visible = false;
    }
  }
}
