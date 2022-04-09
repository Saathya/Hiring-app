import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  CollectionReference feedback =
      FirebaseFirestore.instance.collection('feedback');

  User user = FirebaseAuth.instance.currentUser;

  Future<void> updateUser(Map<String, dynamic> data, context, screen) {
    return users.doc(user.uid).update(data).then((value) {
      Navigator.pushNamed(context, screen);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }




  // Future<String> getAddress(lat, long) async {
  //   final coordinates = new Coordinates(lat, long);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   return first.addressLine;
  // }

  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await users.doc(user.uid).get();
    return doc;
  }

  Future<DocumentSnapshot> getFeedbackData() async {
    DocumentSnapshot doc = await users.doc(user.uid).get();
    return doc;
  }

  updateFavourite(_isLiked, productId, context) {
    if (_isLiked) {
      products.doc(productId).update({
        'favourites': FieldValue.arrayUnion([user.uid])
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to my Favourites'),
        ),
      );
    } else {
      products.doc(productId).update({
        'favourites': FieldValue.arrayRemove([user.uid]),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remove to my Favourites'),
        ),
      );
    }
  }

  updateCall(_isClicked, productId, context) {
    if (_isClicked) {
      products.doc(productId).update({
        'calls': FieldValue.arrayUnion([user.uid])
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to my CallList'),
        ),
      );
    } else {
      products.doc(productId).update({
        'calls': FieldValue.arrayUnion([getUserData()]),
      });
    }
  }
}
