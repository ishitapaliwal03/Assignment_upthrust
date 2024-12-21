import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.2, 0.8, 1.0],
          colors: [
            Colors.purple.shade50, // Light purple at top
            Colors.white,          // White
            Colors.white,          // White
            Colors.purple.shade50, // Light purple at bottom
          ],
        ),
      ),
      child: Center( // Ensures the child is centered
        child: child,
      ),
    );
  }
}
