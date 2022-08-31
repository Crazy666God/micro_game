import 'package:flutter/material.dart';
import 'package:micro_game/entities/bullet.dart';
import 'package:micro_game/entities/player.dart';
import 'package:micro_game/scenes/app_scene.dart';
import 'package:micro_game/utilits/global_vars.dart';

class GameScene extends AppScene {
  final Player _player = Player(spriteName: 'player', numberSprites: 1);
  double _startGlobalPosition = 0;
  final List<Bullet> _listBullets = [];
  final List<Widget> _listWidgets = [];

  @override
  Widget buildScene() {
    return Stack(
      children: [
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
        Stack(
          children: _listWidgets,
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();
    _listWidgets.clear();
    _listBullets.removeWhere((element) => !element.visible);
    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });
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
    _listBullets.add(
      Bullet(
          playerAngle: _player.getAbgle,
          x: _player.x,
          y: _player.y,
          spriteName: 'bullet',
          numberSprites: 1),
    );
  }
}
