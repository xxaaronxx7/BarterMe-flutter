import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/saved_screen/view_single_product_page.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../category_screen/selected_itemdetails.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "Saved items".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getSaved(currentUser?.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Saved Item".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => ViewSingleProductPage(
                                      pName: data[index]['title'],
                                      pAvailability: data[index]
                                          ['availability'],
                                      pSeller: data[index]['sellername'],
                                      vendorId: data[index]['vendorId'],
                                      pQty: data[index]['qty'],
                                      pLocation: data[index]['location'],
                                      pDesc: data[index]['desc'],
                                      pCondition: data[index]['itemcondition'],
                                      firstImg: data[index]['img'],
                                      secondImg: data[index]['secondImg'],
                                      thirdImg: data[index]['thirdImg'],
                                    ));
                              },
                              child: ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  width: 110,
                                  fit: BoxFit.cover,
                                ),
                                title: "${data[index]['title']}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                subtitle: "${data[index]['itemcondition']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              ),
                            );
                          })),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
