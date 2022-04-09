import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Screens/ProductScreen.dart';
import 'package:search_page/search_page.dart';

class Products {
  final String title, category, subCat, location;

  final DocumentSnapshot document;

  Products(
      {this.title,
      this.category,
      this.subCat,
      this.location,
      this.document});
}

class SearchService {
  search({context,productList}){
    showSearch(
          context: context,
          delegate: SearchPage<Products>(
            onQueryUpdate: (s) => print(s),
            items: productList,
            searchLabel: 'Search people',
            suggestion: SingleChildScrollView(child: ProductScreen(true)),
            failure: Center(
              child: Text('No person found :('),
            ),
            filter: (product) => [
              product.subCat,
              product.category,
              product.title,
            ],
            builder: (product) {
              
              return Container(height: 120,
              width:MediaQuery.of(context).size.width,
              child:Card(elevation: 4,
              child:Row(
                children: [
                  Container(width: 100,
                  height: 120,
                  child:Image.network(product.document['images'][0])),
                  SizedBox(width: 10,),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:10),
                        Text(product.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                               SizedBox(height:20),
                         Text(product.subCat,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(children: [
                    Text( "Location: ${product.location}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ],)
                  ],)
                ],
              ),));
            }
             
            ),
          
    );
        

  }
}
