import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:labour_app/Forms/userReview_screen.dart';
import 'package:labour_app/Services/firebase_services.dart';
import 'package:labour_app/Widgets/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:labour_app/Provider/catProvider.dart';

class RegisterCarForm extends StatefulWidget {
  static const String id = 'register-form';

  @override
  _RegisterCarFormState createState() => _RegisterCarFormState();
}

class _RegisterCarFormState extends State<RegisterCarForm> {
  final _formkey = GlobalKey<FormState>();
  FirebaseService _service = FirebaseService();

  var _occupatioController = TextEditingController();
  var _monthController = TextEditingController();
  var _expController = TextEditingController();
  var _workingController = TextEditingController();
  var _aadharController = TextEditingController();
  var _titleController = TextEditingController();
  var _locationController = TextEditingController();

  validate(CategoryProvider provider) {
    if (_formkey.currentState.validate()) {
      if (provider.urlList.isNotEmpty) {
        provider.datatoFirestore.addAll({
          'category': provider.selectedCategory,
          'subcat': provider.selectedSubCat,
          'occupation': _occupatioController.text,
          'time': _monthController.text,
          'experience': _expController.text,
          'working time': _workingController.text,
          'aadhar number': _aadharController.text,
          'title': _titleController.text,
          'location': _locationController.text,
          'RegisterUid': _service.user.uid,
          'images': provider.urlList,
          'postedAt': DateTime.now().microsecondsSinceEpoch,
        });

        print(provider.datatoFirestore);

        Navigator.pushNamed(context, UserReviewScreen.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('image not uploaded'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete required fields'),
        ),
      );
    }
  }

  List<String> _expList = [
    'more than 3 months',
    'more than 6 months ',
    'more than 1 year',
    'more than 2 year',
    'more than 3 year'
  ];

  List<String> _workingList = [
    "5 hour's",
    "6 hour's",
    "8 hour's",
    "7 hour's",
    "10 hour's",
  ];

  @override
  void didChangeDependencies() {
    var _catProvider = Provider.of<CategoryProvider>(context);

    setState(() {
      _occupatioController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['Occupation'];

      _monthController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['time'];
      _expController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['experience'];

      _workingController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['working time'];

      _aadharController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['aadhar number'];

      _titleController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['title'];

      _locationController.text = _catProvider.datatoFirestore.isEmpty
          ? null
          : _catProvider.datatoFirestore['location'];
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    Widget _appBar(title, fieldValue) {
      return AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        title: Text(
          '$title > $fieldValue',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      );
    }

    Widget _brandList() {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(_catProvider.selectedCategory, 'Occupation'),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _catProvider.doc['Occupation'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          _occupatioController.text =
                              _catProvider.doc['Occupation'][index];
                        });
                        Navigator.pop(context);
                      },
                      title: Text(_catProvider.doc['Occupation'][index]),
                    );
                  }),
            )
          ],
        ),
      );
    }

    Widget _listView({fieldValue, list, textController}) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(_catProvider.selectedCategory, fieldValue),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      textController.text = list[index];
                      Navigator.pop(context);
                    },
                    title: Text(list[index]),
                  );
                }),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          'Add some details',
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _catProvider.selectedCategory,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: _monthController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(labelText: 'Date/Month/Year*'),
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete requied field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _brandList();
                          });
                    },
                    child: TextFormField(
                      controller: _occupatioController,
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Occupation*'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please complete requied field';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _aadharController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Aadhar No.*'),
                    maxLength: 12,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete requied field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _listView(
                                fieldValue: 'Experience',
                                list: _expList,
                                textController: _expController);
                          });
                    },
                    child: TextFormField(
                      controller: _expController,
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Experience*'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please complete requied field';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Add title*'),
                    maxLength: 50,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete requied field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _listView(
                                fieldValue: "Working Hour's",
                                list: _workingList,
                                textController: _workingController);
                          });
                    },
                    child: TextFormField(
                      controller: _workingController,
                      enabled: false,
                      decoration: InputDecoration(labelText: "Working Hour's*"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please complete requied field';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                  ),
                  TextFormField(
                    controller: _locationController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Location*'),
                    maxLength: 50,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please complete requied field';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _catProvider.urlList.length == 0
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'No image selected',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : GalleryImage(
                            imageUrls: _catProvider.urlList,
                          ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImagePickerWidget();
                          });
                    },
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          border: NeumorphicBorder(
                              color: Theme.of(context).primaryColor)),
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(_catProvider.urlList.length > 0
                              ? 'Upload more images'
                              : 'Upload Image'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  validate(_catProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
