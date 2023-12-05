import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var userId = ''; // Pag kuha han ID han user current user
  var searchController = TextEditingController();
  getUsername() async {
    var result = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get();

    if (result.docs.isNotEmpty) {
      username = result.docs.single['name'];
      userId = currentUser!.uid; // Set the user ID here
    }
  }
}
