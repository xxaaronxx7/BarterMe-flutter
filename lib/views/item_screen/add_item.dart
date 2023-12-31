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
  AddProduct({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green.shade300,
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
                : ElevatedButton(
                        onPressed: () async {
                          if (controller.iImagesList
                              .any((image) => image != null)) {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Form is valid, perform the submission logic
                              controller.isLoading(true);
                              controller.uploadItem(context);
                              controller.uploadImages();
                              Get.back();
                            }
                          } else {
                            // Show a message indicating that at least one image is required
                            Get.snackbar(
                              "Error",
                              "Please select at least one image.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: "Save"
                            .text
                            .fontFamily(bold)
                            .color(fontGrey)
                            .size(22)
                            .make())
                    .marginOnly(right: 13)
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  customTextField2(
                    hint: "eg. BMW",
                    label: "Item Name : ",
                    controller: controller.inameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the item name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField2(
                    hint: "eg. Carigara, Leyte",
                    label: "Location : ",
                    controller: controller.ilocationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField2(
                    hint: "eg. To Barter into other items",
                    label: "Description : ",
                    isDesc: true,
                    controller: controller.idescController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField2(
                    hint: "eg. Available/ On Deal/ Pending/ Sold",
                    label: "Is item available? : ",
                    controller: controller.iavailabilityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please if the item is available/etc.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField2(
                    hint: "eg. 1 or above",
                    label: "Quantity : ",
                    controller: controller.iquantityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the item quantity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField2(
                    hint: "eg. Used/New/Unused etc.",
                    label: "Item Condition : ",
                    controller: controller.iItemconditionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the item condition';
                      }
                      return null;
                    },
                  ),
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
              ),
            )),
      ),
    );
  }
}
