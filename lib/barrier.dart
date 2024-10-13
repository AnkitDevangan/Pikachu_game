import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyBarrier extends StatelessWidget {
  final double barrierX;
  final double barrierY;
  final double barrierWidth;
  final double barrierHeight;

  MyBarrier({
    required this.barrierX,
    required this.barrierY,
    required this.barrierWidth,
    required this.barrierHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (barrierX + 1) * MediaQuery.of(context).size.width / 2,
      bottom: barrierY * MediaQuery.of(context).size.height / 2,
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth,
        height: MediaQuery.of(context).size.height * barrierHeight,
        child: Lottie.asset(
          "assets/images/dig.json",
          fit: BoxFit.contain,
        ),
        // Image.asset('assets/images/gcac.png',
        // fit: BoxFit.fill,),
        color: Colors.transparent,
      ),
    );
  }
}
