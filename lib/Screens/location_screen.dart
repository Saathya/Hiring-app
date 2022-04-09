// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csc_picker/csc_picker.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:labour_app/Screens/main_screen.dart';
// import 'package:labour_app/Services/firebase_services.dart';
// import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
// import 'package:location/location.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LocationScreen extends StatefulWidget {
//   static const String id = 'location-screen';

//   final String popScreen;
//   final bool locationchanging;

//   const LocationScreen({Key key, this.popScreen, this.locationchanging})
//       : super(key: key);

//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   FirebaseService _service = FirebaseService();
//   bool _loading = false;

//   Location location = new Location();

//   bool _serviceEnabled;

//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//   String _address;
//   String countryValue = "";
//   String stateValue = "";
//   String cityValue = "";
//   String manualaddress;

//   Future<LocationData> getlocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return null;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     _locationData = await location.getLocation();

//     final coordinates =
//         new Coordinates(_locationData.latitude, _locationData.longitude);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var first = addresses.first;

//     setState(() {
//       _address = first.addressLine;
//       countryValue = first.countryName;
//     });
//     return _locationData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.locationchanging == null) {
//       _service.users
//           .doc(_service.user.uid)
//           .get()
//           .then((DocumentSnapshot document) {
//         if (document.exists) {
//           if (document['address'] != null) {
//             if (mounted) {
//               setState(() {
//                 _loading = true;
//               });
//               Navigator.pushReplacementNamed(context, MainScreen.id);
//             }
//           } else {
//             setState(() {
//               _loading = false;
//             });
//           }
//         }
//       });
//     } else {
//       setState(() {
//         _loading = false;
//       });
//     }

//     ProgressDialog progressDialog = ProgressDialog(
//       context: context,
//       backgroundColor: Colors.white,
//       textColor: Colors.black,
//       loadingText: "Fetching Location...",
//     );

//     showBottomScreen(context) {
//       getlocation().then((value) {
//         if (location != null) {
//           progressDialog.dismiss();
//           showModalBottomSheet(
//               isScrollControlled: true,
//               enableDrag: true,
//               context: context,
//               builder: (context) {
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 26,
//                     ),
//                     AppBar(
//                       automaticallyImplyLeading: false,
//                       iconTheme: IconThemeData(color: Colors.black),
//                       elevation: 1,
//                       backgroundColor: Colors.white,
//                       title: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.clear,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'Location',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: SizedBox(
//                           height: 40,
//                           child: TextFormField(
//                             decoration: InputDecoration(
//                               hintText: 'Search City, area or neighbourhood',
//                               hintStyle: TextStyle(color: Colors.grey),
//                               icon: Icon(Icons.search),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         progressDialog.show();
//                         getlocation().then((value) {
//                           if (value != null) {
//                             _service.updateUser({
//                               'location':
//                                   GeoPoint(value.latitude, value.longitude),
//                               'address': _address,
//                             }, context, widget.popScreen).then((value) {
//                               progressDialog.dismiss();
//                               // return Navigator.pushNamed(
//                               //     context, widget.popScreen);
//                             });
//                           }
//                         });
//                       },
//                       horizontalTitleGap: 0.0,
//                       leading: Icon(
//                         Icons.my_location,
//                         color: Colors.blue,
//                       ),
//                       title: Text(
//                         'Use current location',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         location == null ? 'Fetching Location' : _address,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       color: Colors.grey,
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(top: 4, bottom: 4, left: 10),
//                         child: Text(
//                           'CHOOSE CITY',
//                           style: TextStyle(
//                             color: Colors.blueGrey.shade900,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       child: CSCPicker(
//                         layout: Layout.vertical,
//                         flagState: CountryFlag.DISABLE,
//                         dropdownDecoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                         ),
//                         defaultCountry: DefaultCountry.India,
//                         onCountryChanged: (value) {
//                           setState(() {
//                             countryValue = value;
//                           });
//                         },
//                         onStateChanged: (value) {
//                           setState(() {
//                             stateValue = value;
//                           });
//                         },
//                         onCityChanged: (value) {
//                           setState(() {
//                             cityValue = value;
//                             manualaddress =
//                                 '$cityValue, $stateValue, $countryValue';
//                           });

//                           if (value != null) {
//                             _service.updateUser({
//                               'address': manualaddress,
//                               'state': stateValue,
//                               'city': cityValue,
//                               'country': countryValue,
//                             }, context, widget.popScreen);
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               });
//         } else {
//           progressDialog.dismiss();
//         }
//       });
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           Image.asset(
//             "assets/images/location.jpg",
//             filterQuality: FilterQuality.low,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Where do you want\nto hire Peoples/workers',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 25,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'To enjoy all that have to offer you\nwe need to know where to look for them',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           _loading
//               ? Column(
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Text('Fetching location....'),
//                   ],
//                 )
//               : Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20, right: 20, bottom: 10),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _loading
//                                 ? Center(
//                                     child: CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Theme.of(context).primaryColor),
//                                   ))
//                                 : ElevatedButton.icon(
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Theme.of(context).primaryColor),
//                                     ),
//                                     icon: Icon(CupertinoIcons.location_fill),
//                                     label: Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, bottom: 15),
//                                       child: Text(
//                                         'Around me',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       progressDialog.show();
//                                       getlocation().then((value) {
//                                         if (value != null) {
//                                           _service.updateUser({
//                                             'address': _address,
//                                             'location': GeoPoint(value.latitude,
//                                                 value.longitude),
//                                           }, context, widget.popScreen);
//                                         }
//                                       });
//                                     },
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         progressDialog.dismiss();
//                         showBottomScreen(context);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(width: 2),
//                             ),
//                           ),
//                           child: Text(
//                             'Set location manually',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//         ],
//       ),
//     );
//   }
// }
