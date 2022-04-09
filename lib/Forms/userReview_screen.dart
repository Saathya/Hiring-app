import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Screens/main_screen.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:provider/provider.dart';

class UserReviewScreen extends StatefulWidget {
  static const String id = 'user-review';

  @override
  _UserReviewScreenState createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  FirebaseService _service = FirebaseService();

  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool validate = false;

  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _countrCodeController = TextEditingController();

  Future<void> updateUser(provider, Map<String, dynamic> data, context) {
    return _service.users.doc(_service.user.uid).update(data).then((value) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add your details'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        title: Text(
          'Review your Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot>(
            future: _service.getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ));
              }

              _nameController.text = snapshot.data['name'];
              _countrCodeController.text = snapshot.data['mobile'];
              _phoneController.text = snapshot.data['mobile'];
              _emailController.text = snapshot.data['email'];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 38,
                              child: Icon(
                                CupertinoIcons.person_alt,
                                color: Colors.black,
                                size: 60,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              decoration:
                                  InputDecoration(labelText: 'Your Name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Name';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Contact Details',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _countrCodeController,
                                enabled: false,
                                decoration: InputDecoration(
                                  counterText: '10',
                                  labelText: '+91',
                                ),
                              )),
                          SizedBox(width: 13),
                          Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Mobile Number';
                                  }
                                  return null;
                                },
                                autofocus: true,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'Enter your phone number',
                                  hintStyle: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            helperText: 'Enter contact email address'),
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
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Theme.of(context).primaryColor,
                ),
                child: _loading
                    ? true
                    : Text(
                        "Confirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    return updateUser(
                            _provider,
                            {
                              'name': _nameController.text,
                              'mobile': _phoneController.text,
                              'email': _emailController.text,
                            },
                            context)
                        .then((value) {
                      setState(() {
                        _loading = false;
                      });
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter required fields'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
