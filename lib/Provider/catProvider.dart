import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:labour_app/Services/firebase_services.dart';

class CategoryProvider with ChangeNotifier {

FirebaseService _service =FirebaseService();

  DocumentSnapshot doc;
  DocumentSnapshot userDetails;
  String selectedCategory;
  String selectedSubCat;
  List<String> urlList = [];
  Map<String, dynamic> datatoFirestore = {};

  getCategory(selectedCat) {
    this.selectedCategory = selectedCat;
    notifyListeners();
  }
  getSubCategory(selectedsubCat) {
    this.selectedSubCat = selectedsubCat;
    notifyListeners();
  }

  getCatSnapshot(snapshot) {
    this.doc = snapshot;
    notifyListeners();
  }

  getImages(url) {
    this.urlList.add(url);
    notifyListeners();
  }

  getData(data) {
    this.datatoFirestore = data;
    notifyListeners();
  }
  getUserDetails(){
  _service.getUserData().then((value){
  this.userDetails = value;
  notifyListeners();
  });

}
clearSelectedCat(){
  this.selectedCategory = null;
  this.selectedSubCat = null;
  notifyListeners();
}

 clearData(){
  this.urlList =[];
  datatoFirestore ={};
  notifyListeners();
}

  }

