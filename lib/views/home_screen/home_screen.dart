import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/selected_itemdetails.dart';
import 'package:emart_app/views/home_screen/components/featured_button.dart';
import 'package:emart_app/views/home_screen/search_screen.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.green.shade300,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.searchController.text,
                        ));
                  }
                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchAnything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          20.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //featured categories
                  5.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(bold)
                        .make(),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitles2[index]),
                                ],
                              )).toList(),
                    ),
                  ),

                  //all items section
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproducsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproducsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproducsdata[index]['p_imgs'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    2.heightBox,
                                    "${allproducsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .size(18)
                                        .make(),
                                    "${allproducsdata[index]['p_itemcondition']}"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(12)
                                        .make(),
                                    "${allproducsdata[index]['p_location']}"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    10.heightBox
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(10))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => SelectedItemDetails(
                                        title:
                                            "${allproducsdata[index]['p_name']}",
                                        data: allproducsdata[index],
                                      ));
                                });
                              });
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
