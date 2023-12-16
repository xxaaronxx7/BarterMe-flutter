import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/selected_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/lists.dart';

Widget featuredButton({String? title, icon}) {
  var controller = Get.put(ProductController());
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).makeCentered(),
    ],
  )
      .box
      .width(262)
      .height(110)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(10))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    controller.getSubCategories(categoriesList);
    Get.to(() => SelectedCategory(title: title));
  });
}
