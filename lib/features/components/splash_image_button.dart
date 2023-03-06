import 'package:flutter/material.dart';

class SplashImageButton extends StatelessWidget {
  const SplashImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      // color: Colors.grey[800],
      child: Center(
        child: Ink.image(
          image: const AssetImage('assets/images/facebook.png'),
          fit: BoxFit.cover,
          // width: 300.0,
          // height: 200.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
