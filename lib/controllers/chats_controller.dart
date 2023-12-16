import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = FirebaseFirestore.instance.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = Get.find<HomeController>().userId;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  void getChatId() async {
    isLoading(true);

    // Check if mayda na past conversation ini na duduha na users
    await chats
        .where('users.$friendId', isEqualTo: true)
        .where('users.$currentId', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // If mayda na hira past nga conversation ig pupull ini niya then ig gagawas usa usa by id
        chatDocId = snapshot.docs.single.id;
      } else {
        // If waray pa hira conversation, maghihimo hin bago nga document ha database para ha ira conversation
        chats.add({
          'created_on': FieldValue.serverTimestamp(),
          'last_msg': '',
          'users': {friendId: true, currentId: true},
          'toId': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName,
        }).then((value) {
          chatDocId = value.id;
        });
      }
    });

    isLoading(false);
  }

  void sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      // Update chat information
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      // Ig didisplay an imo message ha chat box, together kun ano nga oras gin send, ngan kun na send ba or kun faild ig cacapture niya an error.
      // NOTE: Pirmi ka ma butang hin error handling para masasabtan mo kun ano an error.
      chats.doc(chatDocId).collection(messagesCollection).add({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      }).then((value) {
        print("Message sent successfully");
      }).catchError((error) {
        print("Failed to send message: $error");
      });
    }
  }
}
