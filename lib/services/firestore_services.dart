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

  //get product subcategory
  static getSubcategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subcatergory', isEqualTo: title)
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

  static getMinelist() {
    firestore
        .collection(productsCollection)
        .where('p_minelist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
  }

  static getItem(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }
}
