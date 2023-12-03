import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;

  var subcat = [];
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();

    var data = await rootBundle.loadString("lib/services/category_model.json");

    var decoded = categoryModelFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  addToSave({title, img, sellername, qty, itemcondition, context}) async {
    await firestore.collection(saveCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'qty': qty,
      'itemcondition': itemcondition,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    quantity.value = 0;
  }

  addToMinelist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_minelist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
  }

  removeFromMinelist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_minelist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
  }

  checkIfFav(data) async {
    if (data['p_wishlist'.contains(currentUser!.uid)]) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
