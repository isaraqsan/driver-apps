import 'package:gibas/core/app/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:gibas/core/app/constant/icons_path.dart';

class AnimatedLoadingLogo extends StatefulWidget {
  final double size;
  final String? pathLogo;
  final Color trackColor;
  final Color progressColor;
  final Color? backgroundColor;

  const AnimatedLoadingLogo({
    super.key,
    this.size = 100,
    this.pathLogo,
    this.trackColor = Colors.grey,
    this.progressColor = ColorPalette.primary,
    this.backgroundColor,
  });

  @override
  State<AnimatedLoadingLogo> createState() => _AnimatedLoadingLogoState();
}

class _AnimatedLoadingLogoState extends State<AnimatedLoadingLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size * 0.9,
              height: widget.size * 0.9,
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            Image.asset(
              widget.pathLogo ?? IconsPath.logoWhite,
              width: widget.size * 0.6,
              height: widget.size * 0.6,
            ),
            RotationTransition(
              turns: _controller,
              child: CustomPaint(
                painter: _CircleProgressPainter(
                  progress: 0.65, // 75% lingkaran
                  trackColor: widget.trackColor,
                  progressColor: widget.progressColor,
                  strokeWidth: 3,
                ),
                size: Size(widget.size, widget.size),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  _CircleProgressPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Track (background)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress (animated part)
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.1416 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1416 / 2, // Start at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.trackColor != trackColor || oldDelegate.progressColor != progressColor || oldDelegate.strokeWidth != strokeWidth;
}
