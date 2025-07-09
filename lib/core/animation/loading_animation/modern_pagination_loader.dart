// Modern Pagination Loading Animation
import 'package:flutter/material.dart';
import 'package:mvvm/core/animation/loading_animation/modern_pagination_painter.dart';

class ModernPaginationLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final String? loadingText;

  const ModernPaginationLoader({
    Key? key,
    this.size = 50.0,
    this.color,
    this.loadingText = "Loading more...",
  }) : super(key: key);

  @override
  State<ModernPaginationLoader> createState() => _ModernPaginationLoaderState();
}

class _ModernPaginationLoaderState extends State<ModernPaginationLoader>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animations
    _rotationController.repeat();
    _scaleController.repeat(reverse: true);
    _fadeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([
              _rotationAnimation,
              _scaleAnimation,
              _fadeAnimation,
            ]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: CustomPaint(
                        painter: ModernPaginationPainter(
                          color: color,
                          progress: _rotationAnimation.value,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (widget.loadingText != null) ...[
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value * 0.8,
                  child: Text(
                    widget.loadingText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: color.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
