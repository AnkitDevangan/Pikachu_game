import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameOverScreen extends StatelessWidget {
  final bool gameOver;

  GameOverScreen({required this.gameOver});

  @override
  Widget build(BuildContext context) {
    return gameOver
        ? Center(
            child: Lottie.asset("assets/images/gameover.json"),
          )
        : Container();
  }
}
