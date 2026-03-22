import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

class AnimatedGridBackground extends StatefulWidget {
  const AnimatedGridBackground({super.key});

  @override
  State<AnimatedGridBackground> createState() => _AnimatedGridBackgroundState();
}

class _AnimatedGridBackgroundState extends State<AnimatedGridBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 15 seconds for a slow, continuous, elegant scroll.
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 15))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // To ensure the grid goes behind the safe area, we don't constrain it.
    // We also use AnimatedBuilder to efficiently rebuild only the CustomPaint.
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return CustomPaint(
          painter: _GridPainter(progress: _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Very light premium grid color
    final Paint paint = Paint()
      ..color = AppColors.divider.withValues(alpha: 0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double cellSize = 64.0;
    
    // Diagonal offset movement
    final double offset = progress * cellSize;

    // Draw vertical lines
    // We add buffer cells to ensure lines don't pop out abruptly.
    for (double i = -cellSize; i < size.width + cellSize; i += cellSize) {
      canvas.drawLine(
        Offset(i + offset, 0),
        Offset(i + offset, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double i = -cellSize; i < size.height + cellSize; i += cellSize) {
      canvas.drawLine(
        Offset(0, i + offset),
        Offset(size.width, i + offset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
