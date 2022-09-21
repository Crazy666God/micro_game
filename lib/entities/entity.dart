import 'package:flutter/material.dart';
import 'package:micro_game/point.dart';

abstract class Entity {
  final Size spriteSize;
  Point coordinates;
  final String spriteName;
  bool visible = true;
  late Image sprite;
  final int spriteNumber;

  Entity({required this.coordinates,
    required this.spriteName,
    required this.spriteNumber,
    required this.spriteSize,
  }) {
    sprite = setSprite();
  }

  Point getCoordinates() {
    return Point(coordinates.x, coordinates.y);
  }

  Image setSprite(); 

  void update() {
    move();
  }

  void move();

  Widget build();
}
