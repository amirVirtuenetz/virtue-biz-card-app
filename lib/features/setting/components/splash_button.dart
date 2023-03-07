import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {
  final void Function() onTap;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget child;
  const SplashButton(
      {Key? key,
      required this.onTap,
      this.backgroundColor,
      this.borderRadius,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.white70,
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        highlightColor: Colors.white12,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
