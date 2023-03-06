import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String firstTitle, secondTitle;
  final void Function() onTap;
  const RichTextWidget({
    Key? key,
    required this.firstTitle,
    required this.secondTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: [
            TextSpan(
              text: firstTitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: secondTitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blueAccent,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
