import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoShimmer extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const CupertinoShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<CupertinoShimmer> createState() => _CupertinoShimmerState();
}

class _CupertinoShimmerState extends State<CupertinoShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment(-1.0 + _controller.value * 2, 0),
              end: Alignment(1.0 + _controller.value * 2, 0),
              colors: [
                Colors.white.withOpacity(0.06),
                Colors.white.withOpacity(0.12),
                Colors.white.withOpacity(0.06),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
