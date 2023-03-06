import 'package:flutter/material.dart';

class RichTextField extends StatelessWidget {
  const RichTextField({
    Key? key,
    required this.bioController,
  }) : super(key: key);

  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bioController,
      style: const TextStyle(
        // height: 1,
        fontSize: 16,
        fontFamily: 'InterRegular',
        // color: const Color(0XFF111827),
      ),
      maxLines: 3,
      minLines: 3,
      decoration: InputDecoration(
        hintText: "Add Bio",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        hintStyle: const TextStyle(
          fontSize: 16,
          // height: 1.4,
          fontFamily: "InterRegular",
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        isDense: false,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: const Color(0xff111827).withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
