import 'package:biz_card/core/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class SocialContactCard extends StatelessWidget {
  final void Function() onPressed;
  final void Function()? onTrailingPressed;
  final IconData? leadingIcon;
  final String title;
  final String? trailingTitle;
  final Color? backgroundColor;
  const SocialContactCard({
    Key? key,
    required this.onPressed,
    this.leadingIcon,
    required this.title,
    this.backgroundColor,
    this.trailingTitle,
    this.onTrailingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 15,
      // minLeadingWidth: 10,
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: backgroundColor ?? AppColor.primaryBackgroundColor,
      // textColor: Colors.white,
      // iconColor: Colors.white,
      leading: Transform.translate(
        offset: const Offset(10, 0),
        child: Icon(leadingIcon),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 5, top: 3),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 70,
          height: 50,
          child: Material(
            // color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onTrailingPressed,
              borderRadius: BorderRadius.circular(12),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  trailingTitle ?? "Add",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
