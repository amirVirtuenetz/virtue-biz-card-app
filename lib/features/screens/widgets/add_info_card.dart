import 'package:flutter/material.dart';

class AddInfoToCard extends StatelessWidget {
  final void Function() onPressed;
  const AddInfoToCard({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(
      //     horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_outlined,
                size: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "Add Info to Card",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, bottom: 12),
                child: Text(
                  "Add contact info,links, and more to your card",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
