// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:labour_app/Forms/userReview_screen.dart';
// import 'package:labour_app/Screens/main_screen.dart';

// // import 'package:labour_app/Screens/Authentication/otp_screen.dart';
// // import 'package:labour_app/Screens/main_screen.dart';
// final storage = new FlutterSecureStorage();

// class PhoneAuthServices {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User user = FirebaseAuth.instance.currentUser;

//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   Future<void> addUser(context, uid) async {
//     final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();

//     List<DocumentSnapshot> document = result.docs;

//     if (document.length > 0) {
//       Navigator.pushReplacementNamed(context, MainScreen.id);
//       // } else {
//       //   // Call the user's Collec tionReference to add a new user
//       //   // return users
//       //   //     .doc(
//       //   //   user.uid,
//       //   // )
//       //   //     .set({
//       //   //   'uid': user.uid,
//       //   //   'mobile': user.phoneNumber,
//       //   //   'email': user.email,
//       //   //   'name': user.displayName,
//       //   //   'address': null,
//       //   // }).then((value) {
//       //   //   Navigator.pushReplacementNamed(context, UserName.id);
//       //   // }).catchError((error) => print('Failed to add user: $error'));
//     }
//   }

//   Future<void> verifyPhoneNumber(
//       BuildContext context, String phonenumber, Function setData) async {
//     final PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential credential) async {
//       await _auth.signInWithCredential(credential);
//     };

//     final PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException e) {
//       if (e.code == 'invaid-phone-number') {
//         print('The provided phone number is not valid.');
//       }
//       print('The error is ${e.code}');
//     };

//     final PhoneCodeSent codeSent = (String verificationId, int resendToken) {
//       showSnackBar(context, "Verification Code set on the phone number");
//       setData(verificationId);
//     };

//     try {
//       _auth.verifyPhoneNumber(
//           phoneNumber: phonenumber,
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//            timeout: const Duration(seconds:90),
//           codeAutoRetrievalTimeout: (String verificationId) {
//             showSnackBar(context, "Time Out");
//           });
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   Future<void> signInwithPhoneNumber(
//       String verificationId, String smsCode, BuildContext context) async {
//     try {
//       AuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: verificationId, smsCode: smsCode);
//       UserCredential userCredential =
//           await _auth.signInWithCredential(credential);
//       if (userCredential.user.uid != null) {
//         return users.doc(userCredential.user.uid).set({
//           'uid': userCredential.user.uid,
//           'mobile': user.phoneNumber,
//           'email': null,
//           'name': null,
//           'address': null,
//         }).then((value) async {
//           //before going to location s reen we wil send email verification

//           Navigator.pushReplacementNamed(context, UserReviewScreen.id);
//         }).catchError((onError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to add user'),
//             ),
//           );
//         });
//       }

//       // storeTokenAndData(userCredential);
//       // Navigator.pushAndRemoveUntil(
//       //     context,
//       //     MaterialPageRoute(builder: (builder) => MainScreen()),
//       //     (route) => false);
//       showSnackBar(context, "logged In");
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void showSnackBar(BuildContext context, String text) {
//     final snackBar = SnackBar(content: Text(text));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   // void storeTokenAndData(UserCredential userCredential) async {
//   //   print("storin token and data");
//   //   await storage.write(
//   //       key: "token", value: userCredential.credential.token.toString());
//   //   await storage.write(
//   //       key: "userCredential", value: userCredential.toString());
//   // }

//   // Future<String> getToken() async {
//   //   return await storage.read(key: "token");
// }
