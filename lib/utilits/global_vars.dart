import 'package:micro_game/scenes/app_scene.dart';
import 'package:micro_game/scenes/game_scene.dart';

class GlobalVars {
  static AppScene currentScene = GameScene();
  static String playerSkin = 'ship_green';
  static int shipNumber = 0;
  static String bulletSkin = 'bullet_green';
  static double screenWidth = 0;
  static double screenHeiht = 0;
  static int scoreCounter = 0;
}