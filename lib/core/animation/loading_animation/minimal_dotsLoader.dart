// Alternative: Minimal Dots Loading Animation
import 'package:flutter/material.dart';

class MinimalDotsLoader extends StatefulWidget {
  final Color? color;
  final double dotSize;
  final double spacing;

  const MinimalDotsLoader({
    super.key,
    this.color,
    this.dotSize = 8.0,
    this.spacing = 4.0,
  });

  @override
  State<MinimalDotsLoader> createState() => _MinimalDotsLoaderState();
}

class _MinimalDotsLoaderState extends State<MinimalDotsLoader>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.4,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Start animations with delays
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: widget.spacing),
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: color.withOpacity(_animations[index].value),
                  shape: BoxShape.circle,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
