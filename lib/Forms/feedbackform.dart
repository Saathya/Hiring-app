
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:labour_app/Forms/form_class.dart';
// import 'package:labour_app/Provider/catProvider.dart';
// import 'package:labour_app/Screens/main_screen.dart';
// import 'package:labour_app/Services/firebase_services.dart';
// import 'package:provider/provider.dart';

// class FeedbackForm extends StatefulWidget {
//   const FeedbackForm({Key key}) : super(key: key);
//   static const String id = 'feed-back';

//   @override
//   _FeedbackFormState createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   FirebaseService _service = FirebaseService();

//   final _formkey = GlobalKey<FormState>();

//   bool _loading = false;

//   var _nameController = TextEditingController();
//   var _phoneController = TextEditingController();
//   var _emailController = TextEditingController();


//   Future<void> saveProductsToDb(CategoryProvider provider, context) {
//     return _service.feedback
//         .doc(_service.user.uid)
//         .set(provider.datatoFirestore)
//         .then(
//       (value) {
//         provider.clearData();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//                 'We have received your Profile data and will be notified you once get approved or rechecked by our company'),
//           ),
//         );
//         Navigator.pushReplacementNamed(context, MainScreen.id);
//       },
//     ).catchError((error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(''),
//         ),
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     var _provider = Provider.of<CategoryProvider>(context);

//     FormClass _formclass = FormClass();

//     showFormDialog(list, textController) {
//       return showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return Dialog(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _formclass.appBar(_provider),
//                   Expanded(
//                     child: ListView.builder(
//                         itemCount: list.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             onTap: () {
//                               setState(() {
//                                 textController.text = list[index];
//                               });
//                               Navigator.pop(context);
//                             },
//                             title: Text(list[index]),
//                           );
//                         }),
//                   )
//                 ],
//               ),
//             );
//           });
//     }

//     Widget _listView({fieldValue, list, textController}) {
//       return Dialog(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _formclass.appBar(
//               _provider,
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: list.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     onTap: () {
//                       textController.text = list[index];
//                       Navigator.pop(context);
//                     },
//                     title: Text(list[index]),
//                   );
//                 }),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0.0,
//         title: Text(
//           'Add some details',
//           style: TextStyle(color: Colors.black),
//         ),
//         shape: Border(
//           bottom: BorderSide(color: Colors.grey.shade300),
//         ),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formkey,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                       "${_provider.selectedCategory} > ${_provider.selectedSubCat}"),
//                   if (_provider.selectedSubCat == 'Plumber')
                   
                 
                 
//                   TextFormField(
//                     controller:  _nameController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(labelText: 'Aadhar No.*'),
//                     maxLength: 12,
//                     maxLines: 1,
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Please complete requied field';
//                       }
//                       return null;
//                     },
//                   ),
                 
                  
//                   Divider(
//                     color: Colors.grey,
//                   ),
                 
//                   SizedBox(
//                     height: 80,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: NeumorphicButton(
//                 style: NeumorphicStyle(color: Theme.of(context).primaryColor),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     'Save',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 onPressed: () {
                  
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
