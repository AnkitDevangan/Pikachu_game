import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testing/barrier.dart';
import 'package:testing/dino.dart';
import 'package:testing/gameover.dart';
import 'package:testing/scorescreen.dart';
import 'package:testing/taptoplay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dino variables
  double dinoX = -0.5;
  double dinoY = 1;
  double dinoWidth = 0.2;
  double dinoHeight = 0.4;

  // Barrier variables
  double barrierX = 1;
  double barrierY = 1;
  double barrierWidth = 0.18;
  double barrierHeight = 0.4;

  // Jump variables
  double time = 0;
  double height = 0;
  double gravity = 9.8;
  double velocity = 5;

  // Game state variables
  bool gameHasStarted = false;
  bool midJump = false; // Prevents double jump
  bool gameOver = false;
  int score = 0;
  int highScore = 0;
  bool dinoPassedBarrier = false;
  bool isWinner = false; // Track if the player is a winner

  // Start the game
  void startGame() {
    setState(() {
      gameHasStarted = true;
      isWinner = false; // Reset winner status
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // Check if dino hits the barrier
      if (detectCollision()) {
        gameOver = true;
        timer.cancel();
        setState(() {
          if (score > highScore) {
            highScore = score; // Update high score
          }
        });
      }

      // Loop barrier
      loopBarriers();

      // Update score
      updateScore();

      setState(() {
        barrierX -= 0.01; // Move the barrier left
      });
    });
  }

  // Update score
  void updateScore() {
    if (dinoX > barrierX + barrierWidth && !dinoPassedBarrier) {
      score += 1;
      dinoPassedBarrier = true;

      // Check if the score is greater than 10
      if (score > 9) {
        isWinner = true; // Set winner flag
      }
    }
  }

  // Loop barriers
  void loopBarriers() {
    setState(() {
      if (barrierX <= -1.2) {
        barrierX = 1.2; // Reset barrier position
        dinoPassedBarrier = false;
      }
    });
  }

  // Barrier collision detection
  bool detectCollision() {
    // Implement simple collision detection based on positions and dimensions
    if (dinoX + dinoWidth >= barrierX &&
        dinoX <= barrierX + barrierWidth &&
        dinoY >= barrierY - barrierHeight) {
      return true;
    }
    return false;
  }

  // Dino jump
  void jump() {
    midJump = true;
    time = 0;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // Calculate height based on time, gravity, and velocity
      height = -gravity / 2 * time * time + velocity * time;

      setState(() {
        if (1 - height > 1) {
          resetJump();
          dinoY = 1; // Reset dino's vertical position
          timer.cancel();
        } else {
          dinoY = 1 - height; // Update dino's vertical position
        }
      });

      // Check if game is over
      if (gameOver) {
        timer.cancel();
      }

      // Increment time for the jump equation
      time += 0.01;
    });
  }

  // Reset the jump state
  void resetJump() {
    setState(() {
      midJump = false;
      time = 0; // Reset time for the next jump
    });
  }

  // Play again
  void playAgain() {
    setState(() {
      gameOver = false;
      gameHasStarted = false;
      barrierX = 1; // Reset barrier position
      dinoY = 1; // Reset dino's vertical position
      score = 0; // Reset score
      isWinner = false; // Reset winner status
      midJump = false; // Reset jump state to allow jumping
      time = 0; // Reset time for the next jump
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameOver
          ? playAgain // Restart the game if it's over
          : (gameHasStarted
              ? (midJump ? null : jump)
              : startGame), // Start or jump
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Stack(
                    children: [
                      // Tap to play widget
                      TapToPlay(gameHasStarted: gameHasStarted),

                      // Game over screen widget
                      GameOverScreen(gameOver: gameOver),

                      // Score screen widget
                      ScoreScreen(score: score, highScore: highScore),

                      // Winner message
                      if (isWinner) // Show winner message if player wins
                        Center(
                          child: Text(
                            'You are a Winner!',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      // Dino widget
                      MyDino(
                        dinoX: dinoX,
                        dinoY: dinoY - dinoHeight,
                        dinoWidth: dinoWidth,
                        dinoHeight: dinoHeight,
                      ),

                      // Barrier (cactus) widget
                      MyBarrier(
                        barrierX: barrierX,
                        barrierY: barrierY - barrierHeight,
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
