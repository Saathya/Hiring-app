// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:labour_app/Forms/formsScreen.dart';
// import 'package:labour_app/Provider/catProvider.dart';
// import 'package:labour_app/Services/firebase_services.dart';
// import 'package:provider/provider.dart';

// class RegistrationSubCat extends StatelessWidget {
//   static const String id = 'Regis-sub-screen';

//   @override
//   Widget build(BuildContext context) {

//     DocumentSnapshot _args = ModalRoute.of(context).settings.arguments;

//     FirebaseService _service = FirebaseService();
//      var _catProvider = Provider.of<CategoryProvider>(context);

//     return Scaffold(
//         appBar: AppBar(
//           elevation: 1,
//           shape: Border(
//             bottom: BorderSide(color: Colors.grey),
//           ),
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           title: Text(
//             _args['catName'],
//             style: TextStyle(color: Colors.black, fontSize: 20),
//           ),
//         ),
//         body: Container(
//           child: FutureBuilder<DocumentSnapshot>(
//             future: _service.categories.doc(_args.id).get(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Container();
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               var data = snapshot.data['SubCat'];

//               return Container(
//                 child: ListView.builder(
//                     itemCount: data.length,
//                     itemBuilder: (BuildContext context, int index) {
                     
//                       return Padding(
//                         padding: const EdgeInsets.only(left:8.0,right:8),
//                         child: ListTile(
//                           onTap: () {
//                              _catProvider.getSubCategory(data[index]);
//                              Navigator.pushNamed(context, FormsScreen.id);
//                           },
//                           title: Text(
//                             data[index],
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       );
//                     }),
//               );
//             },
//           ),
//         ));
//   }
// }
