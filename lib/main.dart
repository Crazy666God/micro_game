import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_game/menu_page.dart';
import 'package:micro_game/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .whenComplete(
    () {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom],
      );
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (BuildContext context) => const MenuPage(),
            '/game' : (BuildContext context) => const MyApp(),
          },
          initialRoute: '/',
        ),
      );
    },
  );
}
