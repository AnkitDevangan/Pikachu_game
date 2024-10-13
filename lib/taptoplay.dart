import 'package:flutter/material.dart';

class TapToPlay extends StatelessWidget {
  final bool gameHasStarted;

  TapToPlay({required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container()
        : Center(
            child: Text(
              'TAP TO PLAY',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
          );
  }
}
