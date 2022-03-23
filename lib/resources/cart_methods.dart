import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// add to cart
  Future<String> addToCart(data) async {
    String result = "";
    try {
      final User user = await _auth.currentUser!;
      final uid = user.uid;
      final doc = await _firestore.collection('cart').doc(uid).get();
      if (doc.exists) {
        final List<dynamic> cartList = doc.data()!['cartList'];
        final List<dynamic> newList = [...cartList, data];
        await _firestore.collection('cart').doc(uid).update({
          'cartList': newList,
        });
        result = "success";
      } else {
        await _firestore.collection('cart').doc(uid).set({
          'cartList': [data],
        });
        result = "success";
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  // get cart list
  Stream<Map<String, dynamic>?> getCartList() {
    final User user = _auth.currentUser!;
    final uid = user.uid;
    final doc = _firestore
        .collection('cart')
        .doc(uid)
        .snapshots()
        .map((event) => event.data());
    return doc;
  }

  // remove from cart
  Future<String> removeFromCart(data) async {
    String result = "";
    try {
      final User user = await _auth.currentUser!;
      final uid = user.uid;
      final doc = await _firestore.collection('cart').doc(uid).get();
      if (doc.exists) {
        final List<dynamic> cartList = doc.data()!['cartList'];
        final List<dynamic> newList = cartList.where((element) {
          return element['id'] != data['id'];
        }).toList();
        await _firestore.collection('cart').doc(uid).update({
          'cartList': newList,
        });
        result = "success";
      } else {
        result = "no cart";
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
