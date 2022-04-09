import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:labour_app/Screens/Authentication/EmailAuthScreen.dart';
import 'package:labour_app/Screens/Authentication/google_sign_in.dart';
// import 'package:labour_app/Screens/Authentication/phone_auth_screen.dart';
// import 'package:labour_app/Services/phoneauth_services.dart';

class AuthUi extends StatefulWidget {
  @override
  _AuthUiState createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, EmailAuthScreen.id);
              },
              child: Row(
                children: [
                  Icon(Icons.email_rounded, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Login with Email",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  SizedBox(
          //   width: 220,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.white,
          //       shape: new RoundedRectangleBorder(
          //         borderRadius: new BorderRadius.circular(3.0),
          //       ),
          //     ),
          //     onPressed: () {
          //      Navigator.pushNamed(context, PhoneAuthScreen.id);
          //     },
          //     child: Row(
          //       children: [
          //         Icon(Icons.phone_rounded,color: Colors.red),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text(
          //           "Login with phone",
          //           style: TextStyle(
          //             color: Colors.grey,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SignInButton(
            Buttons.Google,
            text: "Continue with Google",
            onPressed: () async {
              // ignore: unused_local_variable
              User user =
                  await GoogleAuthentication.signInWithGoogle(context: context);

              // if (user != null) {
              //   PhoneAuthServices _authentication = PhoneAuthServices();
              //   _authentication.addUser(context, user.uid);
              // }
            },
          ),

          // SignInButton(
          //   Buttons.FacebookNew,
          //   text: "Sign up with Facebook",
          //   onPressed: () {},
          // ),

          // InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, EmailAuthScreen.id);

          //   },
          //   child: Container(
          //     child: Text(
          //       'Login with Email',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 18,
          //       ),
          //     ),
          //     decoration: BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
