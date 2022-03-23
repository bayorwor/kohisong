import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kohisong/resources/storage_methods.dart';

class ProductMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//add user details to firestore
  Future<String> addProduct(
      {required String name,
      required String price,
      required String description,
      required String qnty,
      required String category,
      required String location,
      required Uint8List image}) async {
    String response = "";
    try {
      String userId = _auth.currentUser!.uid;

      String picUrl =
          await StorageMethods().uploadImageToStorage("products", image, true);

      await _firestore.collection('products').doc().set({
        'name': name,
        'price': price,
        'description': description,
        'qnty': qnty,
        'category': category,
        "location": location,
        "uid": userId,
        "sold": false,
        "createdAt": DateTime.now(),
        "image": picUrl,
      });
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //get my products
  Stream<QuerySnapshot<Map<String, dynamic>?>> getMyProducts() {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('prodcuts')
        .where("uid", isEqualTo: userId)
        .snapshots();
  }

  //get all products
  Stream<QuerySnapshot<Map<String, dynamic>?>> getAllProductsByCategory({
    required String category,
  }) {
    return _firestore
        .collection('products')
        .where("category", isEqualTo: category)
        .snapshots();
  }

//get my products that are not sold
  Stream<QuerySnapshot<Map<String, dynamic>?>> getCompletedMaterials() {
    String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('prodcuts')
        .where('completed', isEqualTo: true)
        .where('uid', isEqualTo: userId)
        .snapshots();
  }

//get materials that are completed
  Stream<QuerySnapshot<Map<String, dynamic>?>> getNotCompleted() {
    String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('clients')
        .where('completed', isEqualTo: false)
        .where('uid', isEqualTo: userId)
        .snapshots();
  }

  //update client details
  updateToDone(String id) {
    String response = "";
    try {
      _firestore.collection('clients').doc(id).update({
        'completed': true,
      });
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //update client details
  deleteOne(String id) {
    String response = "";
    try {
      _firestore.collection('products').doc(id).delete();
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }
}
