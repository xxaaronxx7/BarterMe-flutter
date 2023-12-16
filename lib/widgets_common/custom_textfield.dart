import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? title,
    String? hint,
    String? Function(String?)? validator,
    controller,
    isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        validator: validator,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
      5.heightBox,
    ],
  );
}

Widget customTextField2(
    {String? label,
    String? hint,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool isDesc = false}) {
  return TextFormField(
    validator: validator,
    maxLines: isDesc ? 4 : 1,
    controller: controller,
    decoration: InputDecoration(
      isDense: true,
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white),
    ),
  );
}
