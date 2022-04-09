import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:labour_app/Services/firebase_services.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 5, 8),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 43,
                  child: TextField(
                    onTap: () {},
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Find Labour, Electricians and many more..',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.notifications_none),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    //   return FutureBuilder<DocumentSnapshot>(
        //     future: _service.users.doc(_service.user.uid).get(),
        //     builder:
        //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //       if (snapshot.hasError) {
        //         return Text("Something went wrong");
        //       }

        //       if (snapshot.hasData && !snapshot.data.exists) {
        //         return Text("Address not selected");
        //       }

        //       if (snapshot.connectionState == ConnectionState.done) {
        //         Map<String, dynamic> data = snapshot.data.data();

        //         if (data['address'] == null) {
        //           GeoPoint latLong = data['location'];
        //           _service
        //               .getAddress(latLong.latitude, latLong.longitude)
        //               .then((addres) {
        //             return appBar(addres, context);
        //           });
        //         } else {
        //           return appBar(data["address"], context);
        //         }
        //       }

        //        return  appBar('Fetching location..', context);
        //     },
        //   );
        // }

        // Widget appBar(address, context) {
        //   return AppBar(
        //     backgroundColor: Colors.white,
        //     elevation: 0.0,
        //     automaticallyImplyLeading: false,
        //     title: InkWell(
        //       onTap: () {
        //        return Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (BuildContext context) => LocationScreen(
        //                       locationchanging: true,popScreen: HomeScreen.id,
        //                     )));
        //       },
        //       child: Container(
        //         width: MediaQuery.of(context).size.width,
        //         child: Padding(
        //           padding: const EdgeInsets.only(top: 8, bottom: 8),
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Icon(
        //                 CupertinoIcons.location_solid,
        //                 color: Colors.black,
        //                 size: 18,
        //               ),
        //               Flexible(
        //                 child: Text(
        //                   address,
        //                   style: TextStyle(
        //                     color: Colors.black,
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //               Icon(
        //                 Icons.keyboard_arrow_down_outlined,
        //                 color: Colors.black,
        //                 size: 18,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
