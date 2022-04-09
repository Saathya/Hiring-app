import 'package:flutter/material.dart';

import 'package:labour_app/Widgets/auth_ui.dart';

class LogIn extends StatelessWidget {
  static const String id = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Column(
          children: [
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 90),
                  Image.asset(
                    "assets/images/logo1.png",
                    height: 190,
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Get Hire People",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            )),
            Expanded(
              child: Container(
                child: AuthUi(),
              ),
            ),
            Text(
              'If you continue, you are accepting\nTerms and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ));
  }
}
