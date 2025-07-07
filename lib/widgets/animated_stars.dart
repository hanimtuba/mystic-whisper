import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedStars extends StatefulWidget {
  const AnimatedStars({super.key});

  @override
  State<AnimatedStars> createState() => _AnimatedStarsState();
}

class _AnimatedStarsState extends State<AnimatedStars>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _twinkleController;
  List<Star> stars = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    _twinkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Generate random stars
    for (int i = 0; i < 50; i++) {
      stars.add(Star(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble(),
        size: math.Random().nextDouble() * 2 + 1,
        speed: math.Random().nextDouble() * 0.5 + 0.1,
        opacity: math.Random().nextDouble() * 0.8 + 0.2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: StarsPainter(
            stars: stars,
            animation: _controller.value,
            twinkle: _twinkleController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double animation;
  final double twinkle;

  StarsPainter({
    required this.stars,
    required this.animation,
    required this.twinkle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacity * (0.3 + 0.7 * twinkle))
        ..style = PaintingStyle.fill;

      final double x = star.x * size.width;
      final double y = (star.y + animation * star.speed) % 1.0 * size.height;

      canvas.drawCircle(
        Offset(x, y),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
