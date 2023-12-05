import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/item_screen/components/item_dropdown.dart';
import 'package:emart_app/views/item_screen/components/product_images.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green.shade400,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkFontGrey,
            ),
          ),
          title: "Barter Item".text.color(whiteColor).size(16).make(),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                        onPressed: () async {
                          controller.isLoading(true);
                          await controller.uploadImages();
                          await controller.uploadItem(context);
                          Get.back();
                        },
                        child: "Save"
                            .text
                            .fontFamily(bold)
                            .color(whiteColor)
                            .size(22)
                            .make())
                    .marginOnly(right: 13)
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                customTextField2(
                    hint: "eg. BMW",
                    label: "Item Name : ",
                    controller: controller.inameController),
                10.heightBox,
                customTextField2(
                    hint: "eg. Carigara, Leyte",
                    label: "Location : ",
                    controller: controller.ilocationController),
                10.heightBox,
                customTextField2(
                    hint: "eg. To Barter into other items",
                    label: "Description : ",
                    isDesc: true,
                    controller: controller.idescController),
                10.heightBox,
                customTextField2(
                    hint: "eg. Available/ On Deal/ Pending/ Sold",
                    label: "Is item available? : ",
                    controller: controller.iavailabilityController),
                10.heightBox,
                customTextField2(
                    hint: "eg. 1 or above",
                    label: "Quantity : ",
                    controller: controller.iquantityController),
                10.heightBox,
                customTextField2(
                    hint: "eg. Used/New/Unused etc.",
                    label: "Item Condition : ",
                    controller: controller.iItemconditionController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                const Divider(color: whiteColor),
                normalText(text: "Add image for your item"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.iImagesList[index] != null
                            ? Image.file(
                                controller.iImagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be the Display Image",
                    color: lightGrey),
              ],
            )),
      ),
    );
  }
}
