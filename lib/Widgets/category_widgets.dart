import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Screens/categories/screens_categories.dart';
// import 'package:labour_app/Screens/categories/subCat_screen.dart';
import 'package:labour_app/Screens/product_by_category.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var _catProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future:
              _service.categories.orderBy('sortId', descending: false).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Categories',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, CategoryListScreen.id);
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 12, color: Colors.black),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var doc = snapshot.data.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: InkWell(
                              onTap: () {
                                _catProvider.getCategory(doc['catName']);
                                _catProvider.getCatSnapshot(doc);

                                return Navigator.pushNamed(
                                    context, ProductByCategory.id);

                                // Navigator.pushNamed(
                                //     context, SubCatList.id,
                                //     arguments: doc);
                              },
                              child: Container(
                                width: 62,
                                height: 50,
                                child: Column(
                                  children: [
                                    Image.network(doc['image']),
                                    SizedBox(height: 10),
                                    Text(doc['catName'].toUpperCase(),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
