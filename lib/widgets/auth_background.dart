import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  static const BoxDecoration gradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0F766E),
        Color(0xFF134E4A),
        Color(0xFF0C4A6E),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: gradient,
      child: child,
    );
  }
}
