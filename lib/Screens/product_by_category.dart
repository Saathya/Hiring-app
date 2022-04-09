import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:labour_app/Widgets/product_card.dart';
// import 'package:labour_app/Screens/ProductScreen.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  static const String id = 'product-by-catego';
  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    FirebaseService _service = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${_catProvider.selectedCategory}',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: FutureBuilder<QuerySnapshot>(
              future: _service.products
                  .orderBy('postedAt')
                  .where('category', isEqualTo: _catProvider.selectedCategory)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        'No Products added under selected category',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return Container(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(height: 0.000001,color: Colors.white,),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data.docs[i];
                      return ProductCard(data: data);
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
