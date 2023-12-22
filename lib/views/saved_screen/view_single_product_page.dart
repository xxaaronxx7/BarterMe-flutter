import 'package:emart_app/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emart_app/consts/consts.dart';

import '../chat_screen/chat_screen.dart';

class ViewSingleProductPage extends StatefulWidget {
  final pName;
  final pAvailability;
  final pSeller;
  final pQty;
  final pLocation;
  final pDesc;
  final pCondition;
  final firstImg;
  final secondImg;
  final thirdImg;
  final vendorId;
  ViewSingleProductPage(
      {super.key,
      this.pName,
      this.pAvailability,
      this.pSeller,
      this.pQty,
      this.pLocation,
      this.pDesc,
      this.pCondition,
      this.firstImg,
      this.secondImg,
      this.thirdImg,
      this.vendorId});

  @override
  State<ViewSingleProductPage> createState() => _ViewSingleProductPageState();
}

class _ViewSingleProductPageState extends State<ViewSingleProductPage> {
  late List imgs = [widget.firstImg, widget.secondImg, widget.thirdImg];
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              widget.pName,
              style: TextStyle(color: Colors.black),
            )),
        body: Column(children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      10.heightBox,
                      Text(
                        widget.pName,
                        style: TextStyle(
                            fontSize: 21,
                            color: darkFontGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      10.heightBox,
                      Text(
                        widget.pAvailability,
                        style: TextStyle(
                            fontSize: 21,
                            color: golden,
                            fontWeight: FontWeight.w600),
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.heightBox,
                              Text(
                                'Seller',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.pSeller,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: darkFontGrey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: blue,
                              size: 35,
                            ),
                          ).onTap(() {
                            Get.to(
                              const ChatScreen(),
                              arguments: [widget.pSeller, widget.vendorId],
                            );
                          })
                        ],
                      )
                          .box
                          .height(68)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      // item quantity

                      20.heightBox,
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              Row(
                                children: [
                                  // IconButton(
                                  //     onPressed: () {
                                  //       controller.decreaseQuantity();
                                  //     },
                                  //     icon: const Icon(Icons.remove)),
                                  // controller.quantity.value.text
                                  //     .size(16)
                                  //     .color(darkFontGrey)
                                  //     .fontFamily(bold)
                                  //     .make(),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       controller.increaseQuantity(
                                  //           int.parse(widget.pQty));
                                  //     },
                                  //     icon: const Icon(Icons.add)),
                                  10.widthBox,
                                  Text(
                                    "(${widget.pQty} item)",
                                    style: TextStyle(
                                      color: darkFontGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),

                      15.heightBox,
                      "Location"
                          .text
                          .color(darkFontGrey)
                          .size(19)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Text(
                        widget.pLocation,
                        style: TextStyle(
                          fontSize: 17,
                          color: darkFontGrey,
                        ),
                      ),
                      30.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .size(17)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Text(
                        widget.pLocation,
                        style: TextStyle(
                          fontSize: 17,
                          color: darkFontGrey,
                        ),
                      ),
                      30.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .size(17)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Text(
                        '  ' + widget.pDesc,
                        style: TextStyle(
                          fontSize: 17,
                          color: redOrange,
                        ),
                      ),
                      //item condition
                      30.heightBox,
                      "Item Condition"
                          .text
                          .color(darkFontGrey)
                          .size(17)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Text(
                        widget.pCondition,
                        style: TextStyle(
                          fontSize: 17,
                          color: fontGrey,
                        ),
                      ),
                      //item image swiper section
                      25.heightBox,
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          itemCount: 3,
                          viewportFraction: .95,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imgs[index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox
                    ]))),
          )
        ]));
  }
}
