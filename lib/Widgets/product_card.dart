import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labour_app/Provider/catProvider.dart';
// import 'package:labour_app/Provider/catProvider.dart';
// import 'package:labour_app/Provider/productProvider.dart';
import 'package:labour_app/Services/firebase_services.dart';
// import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object> data;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FirebaseService _service = FirebaseService();

  List fav = [];
  List call = [];

  bool _isLiked = false;
  bool _isClicked = false;

   void _launchCaller(int phonenumber) async {
    var url = "tel: +91 ${phonenumber.toString()}";
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not place Call';
    }
  }

   void getFavourites() {
    _service.products.doc(widget.data.id).get().then((value) {
      if (mounted) {
        setState(() {
          fav = value['favourites'];
        });
      }
      if (fav.contains(_service.user.uid)) {
        if (mounted) {
          setState(() {
            _isLiked = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLiked = false;
          });
        }
      }
    });
  }

  void getCalls(CategoryProvider _provider) {
    _service.products.doc(widget.data.id).get().then((value) {
      if (mounted) {
        setState(() {
          call = value['Calls'];
        });
      }
      if (call.contains(_provider.getUserDetails())) {
        if (mounted) {
          setState(() {
            _isClicked = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isClicked = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var _productProvider = Provider.of<ProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    const double appPadding = 30.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: appPadding / 2,
        horizontal: appPadding / 3,
      ),
      child: Container(
        width: size.width * 0.8,
        padding: EdgeInsets.all(appPadding / 3),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.data['images'][0],
                fit: BoxFit.cover,
                width: size.width * 0.24,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: size.width * 0.24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data['title'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.data['occupation'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_pin, size: 14, color: Colors.black38),
                      SizedBox(width: 1),
                      Text(
                        widget.data['location'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
                    color: _isLiked ? Colors.red : Colors.black,
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                      _service.updateFavourite(
                          _isLiked, widget.data.id, context);
                    },
                  ),
                  Container(
                    width: size.width * 0.12,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(_isClicked
                          ? CupertinoIcons.phone_fill
                          : CupertinoIcons.phone),
                      color: _isClicked ? Colors.red : Colors.black,
                      onPressed: () {
                        setState(() {
                          _isClicked = !_isClicked;
                          _launchCaller(widget.data["phonenumber"]);
                        });
                        _service.updateCall(
                            _isClicked, widget.data.id, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
