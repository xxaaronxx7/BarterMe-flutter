import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget productDropdown(String hint, List<String> list, RxString dropvalue,
    ProductController controller) {
  return Obx(
    () => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: normalText(text: hint, color: fontGrey),
          value: dropvalue.value.isEmpty ? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          }).toList(),
          onChanged: (value) {
            if (hint == "Category") {
              controller.subcategoryValue.value = '';
              controller.populateSubcategory(value.toString());
            }
            dropvalue.value = value.toString();
          },
        ),
      ),
    ),
  );
}
