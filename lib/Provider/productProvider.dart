import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  DocumentSnapshot productData;
  DocumentSnapshot userData;

  getProductDetails(details) {
    this.productData = details;

    notifyListeners();
  }
}
