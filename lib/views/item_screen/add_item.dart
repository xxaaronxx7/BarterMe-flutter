import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/item_screen/components/item_dropdown.dart';
import 'package:emart_app/views/item_screen/components/product_images.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  FocusNode availabilityNode = FocusNode();
  late SingleValueDropDownController _cnt;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();

    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();

    super.dispose();
  }

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
                          if (controller.iImagesList.length > 2 &&
                              controller.iImagesList[2] != null &&
                              controller.iImagesList.any((image) {
                                return image != null;
                              })) {
                            ////////////////
                            if (_formKey.currentState?.validate() ?? false) {
                              // Form is valid, perform the submission logic
                              controller.isLoading(true);
                              // await controller.uploadItem(context);
                              await controller.uploadImages(context);
                              Get.back();
                            }
                          } else {
                            // Show a message indicating that at least one image is required
                            Get.snackbar(
                              "Error",
                              "Please select at least three images.",
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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Item name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    customTextField2(
                      hint: "eg. BMW",
                      // label: "Item Name : ",
                      controller: controller.inameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the item name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    customTextField2(
                      hint: "eg. Carigara, Leyte",
                      // label: "Location : ",
                      controller: controller.ilocationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),

                    customTextField2(
                      hint: "eg. To Barter into other items",
                      // label: "Description : ",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    customTextField2(
                      hint: "eg. 1 or above",
                      // label: "Quantity : ",
                      controller: controller.iquantityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the item quantity';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Is item available?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DropDownTextField(
                            initialValue: 'Available',
                            // controller: _cnt,
                            clearOption: false,
                            // enableSearch: true,
                            // dropdownColor: Colors.green,

                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 3,

                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'Available', value: "Available"),
                              DropDownValueModel(
                                name: 'Sold',
                                value: 'Sold',
                              ),
                              DropDownValueModel(
                                name: 'Pending',
                                value: 'Pending',
                              ),
                            ],
                            onChanged: (name) {
                              if (name.toString().contains('Avail')) {
                                setState(() {
                                  controller.availability = 'Available';
                                });
                              } else if (name.toString().contains('Pending')) {
                                setState(() {
                                  controller.availability = 'Pending';
                                });
                              }
                              if (name.toString().contains('Sold')) {
                                setState(() {
                                  controller.availability = 'Sold';
                                });
                              }

                              print(controller.availability.toString());
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Item Condition",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DropDownTextField(
                            initialValue: 'Good Condition',
                            // controller: _cnt,
                            clearOption: false,
                            // enableSearch: true,
                            // dropdownColor: Colors.green,

                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 4,

                            dropDownList: const [
                              DropDownValueModel(
                                name: 'Pristine',
                                value: 'Pristine',
                              ),
                              DropDownValueModel(
                                  name: 'Good Condition',
                                  value: "Good Condition"),
                              DropDownValueModel(
                                name: 'New',
                                value: 'New',
                              ),
                              DropDownValueModel(
                                name: 'Used',
                                value: 'Used',
                              ),
                            ],
                            onChanged: (name) {
                              if (name.toString().contains('Good')) {
                                setState(() {
                                  controller.condition = 'Good Condition';
                                });
                              } else if (name.toString().contains('Pristine')) {
                                setState(() {
                                  controller.condition = 'Pristine';
                                });
                              }
                              if (name.toString().contains('Used')) {
                                setState(() {
                                  controller.condition = 'Used';
                                });
                              }
                              if (name.toString().contains('New')) {
                                setState(() {
                                  controller.condition = 'New';
                                });
                              }

                              print(controller.condition.toString());
                            },
                          ),
                        ],
                      ),
                    ),

                    // customTextField2(
                    //   hint: "eg. Available/ On Deal/ Pending/ Sold",
                    //   label: "Is item available? : ",
                    //   controller: controller.iavailabilityController,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please if the item is available/etc.';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 10),

                    SizedBox(height: 10),
                    // customTextField2(
                    //   hint: "eg. Used/New/Unused etc.",
                    //   label: "Item Condition : ",
                    //   controller: controller.iItemconditionController,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please enter the item condition';
                    //     }
                    //     return null;
                    //   },
                    // ),
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
                        children: List.generate(3, (index) {
                          return controller.iImagesList[index] != null
                              ? Image.file(
                                  controller.iImagesList[index],
                                  width: 100,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : productImages(label: "${index + 1}").onTap(() {
                                  controller.pickImage(index, context);
                                });
                        }),
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
      ),
    );
  }
}
