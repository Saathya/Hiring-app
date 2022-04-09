import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:labour_app/Screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour_app/Widgets/profile_list_view.dart';
import 'package:labour_app/Widgets/constants.dart';

// import 'package:labour_app/Services/firebase_services.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // FirebaseService _service = FirebaseService();
  String firstname = '';
  String emailaddress = '';
  String mobilenumber = '';

  void getCurrentUserdata() async {
    User user = FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      firstname = vari.data()['name'];
      emailaddress = vari.data()['email'];
      mobilenumber = vari.data()['mobile'];
    });
  }

  @override
  void initState() {
    getCurrentUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 900, width: 414, allowFontScaling: true,);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/images/logo1.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color:Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        Icons.edit,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            firstname.toUpperCase(),
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 1),
          Text(
            emailaddress,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: kSpacingUnit.w * 1.5),
           Text(
           '+91'+mobilenumber,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        // GestureDetector(
        //   onTap: (){
        //         Navigator.pushReplacementNamed(context, MainScreen.id);
        //       },
        //   child: Icon(
        //     Icons.arrow_back_ios,
        //     size: ScreenUtil().setSp(kSpacingUnit.w * 3),
              
        //   ),
        // ),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 5),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  icon: Icons.privacy_tip,
                  text: 'Privacy',
  
                ),
                ProfileListItem(
                  icon: Icons.support_agent_rounded,
                  text: 'Help & Support',
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
                ProfileListItem(
                  icon: Icons.share_rounded,
                  text: 'Invite a Friend',
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, LogIn.id);
                  },
                  child: ProfileListItem(
                    icon: Icons.logout_rounded,
                    text: 'Logout',
                    hasNavigation: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

          


































































      // body: Center(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 300),
      //       Center(
      //           child: Text(
      //         emailaddress,
      //         style: TextStyle(color: Colors.black),
      //       )),
      //       SizedBox(height: 10),
      //       Center(
      //           child: Text(
      //         firstname,
      //         style: TextStyle(color: Colors.black),
      //       )),
      //       Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: NeumorphicButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, LogIn.id);
      //           },
      //           style: NeumorphicStyle(color: Colors.red),
      //           child: Text(
      //             'Log Out Screen',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 20,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
   