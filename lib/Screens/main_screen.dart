import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Forms/formsScreen.dart';
// import 'package:labour_app/Forms/feedbackform.dart';
import 'package:labour_app/Screens/account_screen.dart';
import 'package:labour_app/Screens/chat_screen.dart';
import 'package:labour_app/Screens/home_screen.dart';
import 'package:labour_app/Screens/myAd_screen.dart';

// import 'RegistrationForm/RegistrationCategoriesscreens_categories.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = HomeScreen();
  int _index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            FormsScreen.id,
          );
        },
        backgroundColor: Colors.redAccent,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _index = 0;
                          _currentScreen = HomeScreen();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_index == 0 ? Icons.home : Icons.home_outlined),
                          Text(
                            'HOME',
                            style: TextStyle(
                                color: _index == 0 ? color : Colors.black,
                                fontWeight: _index == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _index = 1;
                          _currentScreen = ChatScreen();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_index == 1
                              ? CupertinoIcons.phone_fill
                              : CupertinoIcons.phone),
                          Text(
                            'CALLS',
                            style: TextStyle(
                                color: _index == 1 ? color : Colors.black,
                                fontWeight: _index == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _index = 2;
                          _currentScreen = MyAdScreen();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_index == 2
                              ? Icons.favorite
                              : Icons.favorite_outline),
                          Text(
                            'FAVOURITES',
                            style: TextStyle(
                                color: _index == 2 ? color : Colors.black,
                                fontWeight: _index == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _index = 3;
                          _currentScreen = AccountScreen();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_index == 3
                              ? CupertinoIcons.person_fill
                              : CupertinoIcons.person),
                          Text(
                            'Account',
                            style: TextStyle(
                                color: _index == 3 ? color : Colors.black,
                                fontWeight: _index == 3
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
