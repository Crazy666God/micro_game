import 'dart:math';
import 'package:micro_game/point.dart';
import 'package:flutter/material.dart';
import 'package:micro_game/entities/bullet.dart';
import 'package:micro_game/entities/meteor.dart';
import 'package:micro_game/entities/player.dart';
import 'package:micro_game/scenes/app_scene.dart';
import 'package:micro_game/score_counter.dart';
import 'package:micro_game/utilits/global_vars.dart';

class GameScene extends AppScene {
  final Random random = Random();
  final Player _player = Player(
      spriteName: GlobalVars.playerSkin, spriteNumber: GlobalVars.shipNumber);
  double _startGlobalPosition = 0;
  final List<Bullet> _listBullets = [];
  final List<Meteor> _listMeteors = [];
  final List<Widget> _listWidgets = [];

  bool flag = true;

  int _meteorsTic = 0;

  @override
  Widget buildScene() {
    return Stack(
      children: [
        const Positioned(
          top: 15,
          left: 15,
          child: ScoreCounter(),
        ),
        Stack(
          children: _listWidgets,
        ),
        _player.build(),
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeiht,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: GlobalVars.screenWidth / 2,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeiht / 2,
            child: GestureDetector(
              onTap: _onAcceleration,
            ),
          ),
        ),
        Positioned(
          top: GlobalVars.screenHeiht / 2,
          left: GlobalVars.screenWidth / 2,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeiht / 2,
            child: GestureDetector(
              onTap: _onShoot,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void update() {
    if (++_meteorsTic >= 40) {
      List<dynamic> list = _randomTrajectory();
      _meteorsTic = 0;
      double spriteSize = random.nextBool() ? 50 : 25;
      _listMeteors.add(
        Meteor(
          angle: list[1],
          coordinates: list[0],
          spriteName: 'meteor',
          spriteNumber: random.nextInt(3),
          spriteSize: Size(spriteSize, spriteSize),
        ),
      );
    }
    _player.update();
    _listWidgets.clear();
    _listBullets.removeWhere((element) => !element.visible);
    _listMeteors.removeWhere((element) => !element.visible);
    // _collisionCheck();
    _addListWidgets(_listMeteors);
    _addListWidgets(_listBullets);
  }

  void _collisionCheck() {
    double x = _player.coordinates.x;
    double y = _player.coordinates.y;
    Size playerSize = _player.spriteSize;

    double meteorR = 30;

    for (var m in _listMeteors) {
      if (!(((x - m.coordinates.x) * (x - m.coordinates.x)) +
              ((y - m.coordinates.y) * (y - m.coordinates.y)) >
          ((playerSize.width / 2 - 10 + meteorR) *
              (playerSize.width / 2 - 10 + meteorR)))) {}
    }

/*
    for (var m in _listMeteors) {
      if (!(m.x > x + playerSize.width ||
          x > m.x + m.spriteSize.width ||
          m.y > y + playerSize.height ||
          y > m.y + m.spriteSize.height)) {
      
      }
    } */
  }

  void _addListWidgets(List<dynamic> list) {
    for (var element in list) {
      _listWidgets.add(element.build());
      element.update();
    }
  }

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if (updateGlobalPosition > _startGlobalPosition + 30) {
      //right
      _player.isMoveRight = true;
    }
    if (updateGlobalPosition < _startGlobalPosition - 30) {
      //left
      _player.isMoveLeft = true;
    }
  }

  void _onAcceleration() {
    _player.isAcceleration = !_player.isAcceleration;
  }

  void _onShoot() {
    Point coordinates = _player.getCoordinates();
    _listBullets.add(
      Bullet(
        playerAngle: _player.getAngle,
        coordinates: coordinates,
        spriteName: GlobalVars.bulletSkin,
        spriteNumber: 0,
      ),
    );
  }

  List<dynamic> _randomTrajectory() {
    List<dynamic> list = [];
    final double width = GlobalVars.screenWidth;
    final double height = GlobalVars.screenHeiht;

    List<Point> points = [
      Point(-100, (random.nextDouble() * (height - 200)) + 100),
      Point(width + 100, (random.nextDouble() * (height - 200)) + 100),
      Point((random.nextDouble() * (width - 200)) + 100, -100),
      Point((random.nextDouble() * (width - 200)) + 100, height + 100),
    ];

    list.add(points[random.nextInt(4)]);

    if (list[0].x == -100) {
      list.add(random.nextInt(140) + 20);
    } else if (list[0].x == GlobalVars.screenWidth + 100) {
      list.add(random.nextInt(140) + 200);
    } else if (list[0].y == -100) {
      list.add(random.nextInt(140) + 110);
    } else if (list[0].y == GlobalVars.screenHeiht + 100) {
      list.add(random.nextInt(140) - 70);
    }

    return list;
  }
}
