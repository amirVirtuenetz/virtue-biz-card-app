import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Color? textColor, backgroundColor;
  final double? elevation;
  final bool? isImageIcon;
  final String? imageIcon;
  const AppTextButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.elevation,
      this.isImageIcon = false,
      this.imageIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.black,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: Colors.black,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: elevation ?? 4,
        maximumSize: const Size(double.infinity, 60),
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: isImageIcon == false
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "$imageIcon",
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
