import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/selected_itemdetails.dart';
import 'package:emart_app/views/item_screen/add_item.dart';
import 'package:emart_app/views/widgets/text_style.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => AddProduct());
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: myItems, color: fontGrey, size: 16.0),
          actions: [
            Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d, ' 'yy')
                      .format(DateTime.now())),
            )
          ],
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getItem(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No Items to Barter".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                          data.length,
                          (index) => Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => SelectedItemDetails(
                                          data: data[index],
                                          title: "${data[index]['p_name']}",
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_imgs'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: "${data[index]['p_name']}"
                                      .text
                                      .color(darkFontGrey)
                                      .size(14)
                                      .fontFamily(semibold)
                                      .make(),
                                  subtitle: "${data[index]['p_availability']}"
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                      children: List.generate(
                                        popupMenuTitles.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(popMenuIcons[index]),
                                              10.widthBox,
                                              popupMenuTitles[index]
                                                  .text
                                                  .color(darkFontGrey)
                                                  .make()
                                            ],
                                          ).onTap(() async {
                                            switch (index) {
                                              case 0:
                                                controller
                                                    .removeItem(data[index].id);
                                                VxToast.show(context,
                                                    msg: "Item removed");
                                                break;
                                              default:
                                            }
                                          }),
                                        ),
                                      ),
                                    ).box.white.width(120).roundedSM.make(),
                                    clickType: VxClickType.singleClick,
                                    child: const Icon(Icons.more_vert_rounded),
                                  ),
                                ),
                              )),
                    ),
                  ),
                );
              }
            }));
  }
}
