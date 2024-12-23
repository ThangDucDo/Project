import 'package:flutter/material.dart';
import 'dart:math';

class PendulumAnimation extends StatefulWidget {
  const PendulumAnimation({super.key});

  @override
  State<PendulumAnimation> createState() => _PendulumAnimationState();
}

class _PendulumAnimationState extends State<PendulumAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -pi / 4, end: pi / 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            _builtLine(
              tY: 100.0,
              maxWidth: maxWidth,
              width: 200,
              height: 10,
              color: Colors.black,
            ),
            _builtPendulum(
              tY: 100.0,
              maxWidth: maxWidth,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _builtLine({
    required double tY,
    required double maxWidth,
    double width = 200,
    double height = 10,
    Color color = Colors.black,
  }) {
    double cX = maxWidth / 2;

    return Positioned(
      left: cX - (width / 2),
      top: tY - (height / 2),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }

  Widget _builtPendulum({
    required double tY,
    required double maxWidth,
  }) {
    double cX = maxWidth / 2;
    return Positioned(
      right: cX - 20,
      top: tY - 5,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  width: 4,
                  height: 200,
                  color: Colors.black,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
