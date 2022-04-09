// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:labour_app/Services/phoneauth_services.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// // import 'package:labour_app/Services/phoneauth_services.dart';
// // ignore: import_of_legacy_library_into_null_safe

// class PhoneAuthScreen extends StatefulWidget {
//   static const String id = 'phone-auth';

//   @override
//   _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
// }

// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   TextEditingController phoneNumberController = TextEditingController();
//   int start = 90;
//   bool wait = false;
//   String buttonName = "Send";
//   PhoneAuthServices _authScreen = PhoneAuthServices();

//   String verificationIdFinal = "";
//   String smsCode = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           'SignUp',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 150,
//               ),
//               textField(),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width - 34,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.grey,
//                         margin: EdgeInsets.symmetric(horizontal: 12),
//                       ),
//                     ),
//                     Text(
//                       "Enter 6 digit OTP",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 1,
//                         color: Colors.grey,
//                         margin: EdgeInsets.symmetric(horizontal: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               otpField(),
//               SizedBox(
//                 height: 40,
//               ),
//               RichText(
//                 text: TextSpan(children: [
//                   TextSpan(
//                     text: "Send OTP again in",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextSpan(
//                     text: " 00:$start",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.redAccent,
//                     ),
//                   ),
//                   TextSpan(
//                     text: " sec",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.redAccent,
//                     ),
//                   ),
//                 ]),
//               ),
//               SizedBox(
//                 height: 150,
//               ),
//               InkWell(
//                 onTap: () {
//                   _authScreen.signInwithPhoneNumber(
//                       verificationIdFinal, smsCode, context);
//                 },
//                 child: Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width - 60,
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurpleAccent,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Let's Go",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void startTimer() {
//     const onsec = Duration(seconds: 1);
//     // ignore: unused_local_variable
//     Timer _timer = Timer.periodic(onsec, (timer) {
//       if (start == 0) {
//         setState(() {
//           timer.cancel();
//           wait = false;
//         });
//       } else {
//         setState(() {
//           start--;
//         });
//       }
//     });
//   }

//   Widget otpField() {
//     return OTPTextField(
//       length: 6,
//       width: MediaQuery.of(context).size.width - 34,
//       textFieldAlignment: MainAxisAlignment.spaceAround,
//       fieldWidth: 45,
//       fieldStyle: FieldStyle.box,
//       otpFieldStyle: OtpFieldStyle(
//         backgroundColor: Colors.white,
//         borderColor: Colors.black,
//       ),
//       outlineBorderRadius: 15,
//       style: TextStyle(fontSize: 17, color: Colors.black),
//       onCompleted: (pin) {
//         print("Completed: " + pin);
//         setState(() {
//           smsCode = pin;
//         });
//       },
//     );
//   }

//   Widget textField() {
//     return Container(
//       width: MediaQuery.of(context).size.width - 40,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: TextFormField(
//         controller: phoneNumberController,
//         maxLength: 10,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: "Enter your phone Number",
//             hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 8, vertical: 19),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
//               child: Text(
//                 "(+91)",
//                 style: TextStyle(color: Colors.black, fontSize: 17),
//               ),
//             ),
//             suffixIcon: InkWell(
//               onTap: wait
//                   ? null
//                   : () async {
//                       startTimer();
//                       setState(() {
//                         start = 90;
//                         wait = true;
//                         buttonName = "Resend";
//                       });
//                       await _authScreen.verifyPhoneNumber(
//                           context, "+91${phoneNumberController.text}", setData);
//                     },
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 child: Text(
//                   buttonName,
//                   style: TextStyle(
//                       color: wait ? Colors.grey : Colors.black,
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )),
//       ),
//     );
//   }

//   void setData(verificationId) {
//     setState(() {
//       verificationIdFinal = verificationId;
//     });
//     startTimer();
//   }
// }

// body: Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 40,
//       ),
//       CircleAvatar(
//         radius: 30,
//         backgroundColor: Colors.blue.shade100,
//         child: Icon(
//           CupertinoIcons.person_alt_circle,
//           color: Colors.white,
//           size: 50,
//         ),
//       ),
//       SizedBox(height: 12),
//       Text('Enter Your Phone Number',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//       SizedBox(height: 10),
//       Text('We will send confirmation code to your phone',
//           style: TextStyle(color: Colors.grey)),
//       Row(children: [
//         Expanded(
//             flex: 1,
//             child: TextFormField(
//               controller: countryCodeController,
//               enabled: false,
//               decoration: InputDecoration(
//                 counterText: '10',
//                 labelText: 'Country code',
//               ),
//             )),
//         SizedBox(width: 13),
//         Expanded(
//             flex: 3,
//             child: TextFormField(
//               onChanged: (value) {
//                 if (value.length == 10) {
//                   setState(() {
//                     validate = true;
//                   });
//                 }
//                 if (value.length < 10) {
//                   setState(() {
//                     validate = false;
//                   });
//                 }
//               },
//               autofocus: true,
//               maxLength: 10,
//               keyboardType: TextInputType.phone,
//               controller: phoneNumberController,
//               decoration: InputDecoration(
//                 labelText: 'Number',
//                 hintText: 'Enter your phone number',
//                 hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
//               ),
//             )),
//       ])
//     ],
//   ),
// ),
// bottomNavigationBar: SafeArea(
//   child: Padding(
//     padding: const EdgeInsets.all(12.0),
//     child: AbsorbPointer(
//       absorbing: validate ? false : true,
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: validate == true
//               ? MaterialStateProperty.all(Theme.of(context).primaryColor)
//               : MaterialStateProperty.all(Colors.grey),
//         ),
//         onPressed: () {  },
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             'Next',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),

//       ),
//     ),
//   ),
