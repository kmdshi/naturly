// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputWrapper extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TextInputWrapper({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      controller: controller,
      decoration: InputDecoration(
        // suffixIcon: Icon(Icons.password),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        //   borderSide: BorderSide(
        //     width: 0.5,
        //     color: Colors.black.withValues(alpha: 0.45),
        //   ),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        //   borderSide: BorderSide(
        //     width: 0.5,
        //     color: Colors.black.withValues(alpha: 0.1),
        //   ),
        // ),
      ),
    );
  }
}
