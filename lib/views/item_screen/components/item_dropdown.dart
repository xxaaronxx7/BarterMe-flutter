import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            child: e.toString().text.make(),
            value: e,
          );
        }).toList(),
        onChanged: (value) {
          if (hint == "Category") {
            controller.subcategoryValue.value;
            controller.populateSubcategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        },
      ),
    )
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
