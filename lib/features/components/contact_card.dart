import 'package:flutter/material.dart';

class SocialContactCard extends StatelessWidget {
  final void Function() onPressed;
  final IconData? leadingIcon;
  final String title;
  const SocialContactCard({
    Key? key,
    required this.onPressed,
    this.leadingIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      // minLeadingWidth: 10,
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: Colors.indigoAccent,
      textColor: Colors.white,
      iconColor: Colors.white,
      leading: Transform.translate(
        offset: const Offset(15, 0),
        child: Icon(leadingIcon),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 50,
          height: 35,
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(12),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
