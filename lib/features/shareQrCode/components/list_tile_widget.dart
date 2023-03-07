import 'package:flutter/material.dart';

class QRCodeScanListTile extends StatelessWidget {
  final String title;
  final double? topRadius, bottomRadius;
  final IconData iconData;
  final void Function() onTap;
  const QRCodeScanListTile(
      {Key? key,
      required this.title,
      this.topRadius,
      this.bottomRadius,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0XFFF4F4F4),
          border: Border.all(width: 0.2, color: Colors.grey),
          // color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius ?? 1),
            topRight: Radius.circular(topRadius ?? 1),
            bottomLeft: Radius.circular(bottomRadius ?? 12),
            bottomRight: Radius.circular(bottomRadius ?? 12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(iconData),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
