
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Screens/Authentication/EmailAuthScreen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String id = 'reset-pass';

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.red,
                  size: 75,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Forgot\nPassword',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Send us your email,\nwe will send link to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    labelText: 'Registered Email',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (value) {
                    final bool isValid =
                        EmailValidator.validate(_emailController.text);
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    if (value.isNotEmpty && isValid == false) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Send'),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()){
             FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then((value) {
              Navigator.pushReplacementNamed(context, EmailAuthScreen.id);
                });
          }
        },
      ),
    );
  }
}
