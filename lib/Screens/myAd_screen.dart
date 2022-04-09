import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:labour_app/Widgets/product_card.dart';

class MyAdScreen extends StatefulWidget {
  @override
  _MyAdScreenState createState() => _MyAdScreenState();
}

class _MyAdScreenState extends State<MyAdScreen> {
  FirebaseService _service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'My Favourites',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: StreamBuilder<QuerySnapshot>(
            stream: _service.products
                .where('favourites', arrayContains: _service.user.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(left: 140, right: 140),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                );
              }
              if (snapshot.data.docs.length == 0) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(
                      'No Favourites added',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Container(
              
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 0.00001,color: Colors.white,),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int i) {
                    var data = snapshot.data.docs[i];
                    return ProductCard(data: data);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
