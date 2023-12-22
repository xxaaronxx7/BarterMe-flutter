import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedItemDetails extends StatefulWidget {
  final String? title;
  final vendorId;
  final dynamic data;
  const SelectedItemDetails(
      {Key? key, required this.title, this.data, this.vendorId})
      : super(key: key);

  @override
  State<SelectedItemDetails> createState() => _SelectedItemDetailsState();
}

class _SelectedItemDetailsState extends State<SelectedItemDetails> {
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  var id = '';

  getUserId() async {
    var result = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser?.uid)
        .get();

    if (result.docs.isNotEmpty) {
      setState(() {
        id = result.docs.single['id'];
      });
      print(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: widget.title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromMinelist(widget.data.id, context);
                    } else {
                      controller.addToMinelist(widget.data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    //title and details
                    widget.title!.text
                        .size(21)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    //10.heightBox,
                    ////rating
                    //VxRating(
                    //    onRatingUpdate: (value) {},
                    //    normalColor: textfieldGrey,
                    //    selectionColor: golden,
                    //    count: 5,
                    //    size: 25,
                    //   stepInt: true),

                    10.heightBox,
                    "${widget.data['p_availability']}"
                        .text
                        .color(golden)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,

                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${widget.data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                          ],
                        )),
                        if (id != widget.data['vendor_id'])
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: blue,
                              size: 35,
                            ),
                          ).onTap(() {
                            Get.to(
                              const ChatScreen(),
                              arguments: [
                                widget.data['p_seller'],
                                widget.data['vendor_id']
                              ],
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
                            Obx(
                              () => Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                      },
                                      icon: const Icon(Icons.remove)),
                                  controller.quantity.value.text
                                      .size(16)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(int.parse(
                                            widget.data['p_quantity']));
                                      },
                                      icon: const Icon(Icons.add)),
                                  10.widthBox,
                                  "(${widget.data['p_quantity']} available)"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),

                    //location
                    15.heightBox,
                    "Location"
                        .text
                        .color(darkFontGrey)
                        .size(19)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    "${widget.data['p_location']}"
                        .text
                        .color(fontGrey)
                        .size(17)
                        .make(),
                    //item description
                    30.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .size(17)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    "   ${widget.data['p_desc']}"
                        .text
                        .color(redOrange)
                        .size(17)
                        .make(),

                    //item condition
                    30.heightBox,
                    "Item Condition"
                        .text
                        .color(darkFontGrey)
                        .size(17)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    "${widget.data['p_itemcondition']}"
                        .text
                        .color(fontGrey)
                        .size(16)
                        .make(),
                    //item image swiper section
                    25.heightBox,
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        itemCount: widget.data['p_imgs'].length,
                        viewportFraction: .95,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox
                  ],
                ),
              ),
            )),
            if (id != widget.data['vendor_id'])
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                    color: redColor,
                    onPress: () {
                      controller.addToSave(
                          context: context,
                          img: widget.data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: widget.data['p_seller'],
                          title: widget.data['p_name'],
                          secondImg: widget.data['p_imgs'][1],
                          thirdImg: widget.data['p_imgs'][2],
                          location: widget.data['p_location'],
                          availability: widget.data['p_availability'],
                          desc: widget.data['p_desc'],
                          itemcondition: widget.data['p_itemcondition'],
                          vendorId: widget.data['vendor_id']);
                      VxToast.show(context, msg: "Saved");
                    },
                    textColor: whiteColor,
                    title: "Save Item"),
              ),
            5.heightBox
          ],
        ),
      ),
    );
  }
}
