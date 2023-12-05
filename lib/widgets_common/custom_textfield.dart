import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:flutter/material.dart';

Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
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

Widget customTextField2({label, hint, controller, isDesc = false}) {
  return TextFormField(
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: whiteColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: whiteColor,
            )),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
