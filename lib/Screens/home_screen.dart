import 'package:flutter/cupertino.dart';
import 'package:labour_app/Provider/catProvider.dart';
import 'package:labour_app/Screens/ProductScreen.dart';
import 'package:labour_app/Widgets/banner_widget.dart';
// import 'package:labour_app/Widgets/banner_widget.dart';
import 'package:labour_app/Widgets/category_widgets.dart';
import 'package:labour_app/Widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    _catProvider.clearSelectedCat();
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SafeArea(
            child: CustomAppBar(),
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 12, 8),
                  child: Column(
                    children: [
                      BannerWidget(),
                      CategoryWidget(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ProductScreen(false),
            ],
          ),
        ));
  }
}
