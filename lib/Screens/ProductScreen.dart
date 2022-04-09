import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:labour_app/Widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const String id = 'product-screen';

  final bool proScreen;
  ProductScreen(this.proScreen);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirebaseService _service = FirebaseService();
    var _catProvider = Provider.of<CategoryProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: FutureBuilder<QuerySnapshot>(
            future: _service.products
                .orderBy('postedAt')
                .where('category', isEqualTo: _catProvider.selectedCategory)
                .get(),
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
                      'No Products added under selected category',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Container(
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(
                          'Fresh Reccomendations',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.size,
                        itemBuilder: (BuildContext context, int i) {
                          var data = snapshot.data.docs[i];
                          return ProductCard(data: data);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
