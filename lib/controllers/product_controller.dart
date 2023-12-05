import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var subcat = [];
  var isFav = false.obs;
  var isLoading = false.obs;

  var inameController = TextEditingController();
  var ilocationController = TextEditingController();
  var idescController = TextEditingController();
  var iavailabilityController = TextEditingController();
  var iquantityController = TextEditingController();
  var iItemconditionController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var iImagesListLinks = [];
  var iImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        iImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    iImagesListLinks.clear();
    for (var item in iImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/users/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        iImagesListLinks.add(n);
      }
    }
  }

  uploadItem(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'p_category': categoryValue.value,
      'p_subcatergory': subcategoryValue.value,
      'p_imgs': FieldValue.arrayUnion(iImagesListLinks),
      'p_minelist': FieldValue.arrayUnion([]),
      'p_desc': idescController.text,
      'p_name': inameController.text,
      'p_quantity': iquantityController.text,
      'p_itemcondition': iItemconditionController.text,
      'p_location': ilocationController.text,
      'p_availability': iavailabilityController.text,
      'p_seller': Get.find<HomeController>().userId,
      'vendor_id': currentUser!.uid,
    });
    isLoading(false);

    VxToast.show(context, msg: "Item Uploaded");
  }

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

  addToMinelist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_minelist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to Minelist");
  }

  removeFromMinelist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_minelist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from Minelist");
  }

  checkIfFav(data) async {
    if (data['p_minelist'.contains(currentUser!.uid)]) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
