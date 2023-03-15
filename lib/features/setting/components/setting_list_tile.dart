import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  final void Function() onTap;
  final Color? backgroundColor;
  final String title;
  final TextStyle? textStyle;
  const SettingListTile({
    Key? key,
    required this.onTap,
    this.backgroundColor,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.white70,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // splashColor: Colors.white,
        highlightColor: Colors.white12,
        onTap: onTap,
        child: ListTile(
          enabled: true,
          dense: true,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          enableFeedback: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          leading: Transform.translate(
            offset: const Offset(5, 0),
            child: const Icon(
              CupertinoIcons.person_circle_fill,
              size: 25,
            ),
          ),
          title: Text(
            title,
            style: textStyle ??
                const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
          trailing: FittedBox(
            child: IconButton(
              onPressed: onTap,
              icon: Transform.translate(
                offset: const Offset(10, 0),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingSecondListTile extends StatelessWidget {
  final void Function() onTap;
  final Color? backgroundColor;
  final String title;
  final TextStyle? textStyle;
  final double? verticalPadding, horizontalPadding;
  const SettingSecondListTile({
    Key? key,
    required this.onTap,
    this.backgroundColor,
    required this.title,
    this.textStyle,
    this.verticalPadding,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.white70,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // splashColor: Colors.white,
        highlightColor: Colors.white12,
        onTap: onTap,
        child: ListTile(
          enabled: true,
          dense: true,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          enableFeedback: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 10,
              vertical: verticalPadding ?? 0),
          title: Text(
            title,
            style: textStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
          trailing: IconButton(
            onPressed: onTap,
            icon: Transform.translate(
              offset: const Offset(10, 0),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
