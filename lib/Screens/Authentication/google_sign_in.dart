import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:labour_app/Screens/Authentication/email_verification_screen.dart';
import 'package:labour_app/Screens/main_screen.dart';

class GoogleAuthentication {
  static SnackBar customSnackBar({@required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<User> signInWithGoogle({@required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        if (userCredential.user.uid != null) {
          return users.doc(userCredential.user.uid).set({
            'uid': userCredential.user.uid,
            'mobile': null,
            'email': userCredential.user.email,
            'name': userCredential.user.displayName,
          }).then((value) async {
            //before going to location s reen we wil send email verification

            await userCredential.user.sendEmailVerification().then((value) {
              Navigator.pushReplacementNamed(
                  context, EmailVerificationScreen.id);
            });
          }).catchError((onError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add user'),
              ),
            );
          });
        } else if (userCredential.user.email != null) {
          Navigator.pushReplacementNamed(context, MainScreen.id);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'account-exists-with-different-credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'invalid-credential',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: 'Login Failed',
          ),
        );
      }
    }

    return user;
  }
}













    //  else {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken,
    //   );

    //   try {
    //     final UserCredential userCredential =
    //         await auth.signInWithCredential(credential);

    //     if (userCredential.user.uid != null) {
    //       Navigator.pushReplacementNamed(context, MainScreen.id);
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'account-exists-with-different-credential') {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         customSnackBar(
    //           content: 'account-exists-with-different-credential.',
    //         ),
    //       );
    //     } else if (e.code == 'invalid-credential') {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         customSnackBar(
    //           content: 'invalid-credential',
    //         ),
    //       );
    //     }
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       customSnackBar(
    //         content: 'Login Failed',
    //       ),
    //     );
    //   }