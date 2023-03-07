import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget child;
  const BackgroundContainer(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0XFFF4F4F4),
        // color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
