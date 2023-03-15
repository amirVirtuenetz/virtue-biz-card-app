import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? fillColor;
  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: fillColor ?? Colors.white,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: child,
    );
  }
}
