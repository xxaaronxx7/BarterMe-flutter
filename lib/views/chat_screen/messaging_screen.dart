import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "My Messages",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.data?.size == 0) {
            return Center(
              child: Text(
                "No messages yet!",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var friendName = data?[index].get('friend_name');
                        var toId = data?[index].get('toId');

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => const ChatScreen(),
                                  arguments: [friendName, toId]);
                            },
                            leading: CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person, color: whiteColor),
                            ),
                            title: Text(
                              friendName ?? '',
                              style: TextStyle(
                                  color: darkFontGrey, fontFamily: semibold),
                            ),
                            subtitle: Text(data?[index].get('last_msg') ?? ''),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
