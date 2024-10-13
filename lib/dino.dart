import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyDino extends StatelessWidget {
  final double dinoX;
  final double dinoY;
  final double dinoWidth;
  final double dinoHeight;

  MyDino({
    required this.dinoX,
    required this.dinoY,
    required this.dinoWidth,
    required this.dinoHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (dinoX + 1) * MediaQuery.of(context).size.width / 2,
      top: dinoY * MediaQuery.of(context).size.height / 2,
      child: Container(
        width: MediaQuery.of(context).size.width * dinoWidth,
        height: MediaQuery.of(context).size.height * dinoHeight,
        child: Container(
          color: Colors.transparent,
          child: Lottie.asset('assets/images/pika.json', fit: BoxFit.contain),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
