import 'package:emart_app/consts/consts.dart';


class FirestoreServices {

//get users data


  static getUser(uid) {

    return firestore

        .collection(usersCollection)

        .where('id', isEqualTo: uid)

        .snapshots();

  }


  //get products according to category


  static getProducts(category) {

    return firestore

        .collection(productsCollection)

        .where('p_category', isEqualTo: category)

        .snapshots();

  }


  //get saved item


  static getSaved(uid) {

    return firestore

        .collection(saveCollection)

        .where('added_by', isEqualTo: uid)

        .snapshots();

  }


  //delete item


  static deleteDocument(docId) {

    return firestore.collection(saveCollection).doc(docId).delete();

  }


  static getChatMessages(docId) {

    return firestore

        .collection(chatsCollection)

        .doc(docId)

        .collection(messagesCollection)

        .orderBy('created_on', descending: false)

        .snapshots();

  }

}

