import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';

class MinelistScreen extends StatelessWidget {
  const MinelistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "My Minelist",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices.getMinelist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Items on Minelist yet!",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                    "${data[index]['p_imgs'][0]}",
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "${data[index]['p_name']}",
                    style: TextStyle(
                      fontFamily: semibold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "${data[index]['p_itemcondition']}",
                    style: TextStyle(
                      color: redColor,
                      fontFamily: semibold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.favorite,
                    color: redColor,
                  ).onTap(() async {
                    await firestore
                        .collection(productsCollection)
                        .doc(data[index].id)
                        .set({
                      'p_minelist': FieldValue.arrayRemove([currentUser!.uid])
                    }, SetOptions(merge: true));
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
