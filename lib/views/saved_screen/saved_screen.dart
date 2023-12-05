import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/selected_itemdetails.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "Saved items".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getSaved(currentUser!.uid),
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
                children: List.generate(
                    data.length,
                    (index) => Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => SelectedItemDetails(
                                  title: "${data[index]['title']}",
                                  data: data[index]));
                            },
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
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          ),
                        )),
              ),
            );
          }
        },
      ),
    );
  }
}
