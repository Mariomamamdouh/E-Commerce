import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:haidy/add.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/services.dart';
import 'main.dart';

class DetailsPage extends StatefulWidget {
  final heroTag;
  final categoryName;

  DetailsPage({this.heroTag, this.categoryName});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController controller = new TextEditingController();

  static var locationMessage = "";
  static var lat;
  static var long;
  //String name = _namecontroller.text;
  //String capitalizedName = _namecontroller.text.substring(0,1).toUpperCase() +_namecontroller.text.substring(1);

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();

    print("$lastPosition");
    lat = position.latitude;
    long = position.longitude;
    setState(() {
      locationMessage = "Latitude : $lat , Longitude : $long";
    });
  }

  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();

  TextEditingController _numoftable = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ), //  two argument appBar & body ده عشان اقسم الصفحة بتاعتي للجزء الي فوق والبادي ده عنده
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Text(
                  "Add Restaurant",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                imageProfile(),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    hintText: "Name Of Restaurant",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Fill name of Restaurant ';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  controller: _descontroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    hintText: "Description,",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Fill description of Restaurant ";
                    }
                    return null;
                  },

                  // return 'Valid Name';
                ),
                SizedBox(
                  height: 35,
                ),

                TextFormField(
                  controller: _numoftable,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    hintText: "Number Of tables",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Fill number of table ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text('Number Of Seats '),
                Text(
                  '6 Seats',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),

                SizedBox(
                  height: 35,
                ),
                /*   TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    hintText: "Time Slots",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),

                  /*   validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill time solts ';
                      }
                    },*/

                */
                Text('Time Slots'),
                Container(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Chip(
                        label: Text('9:00-9:30'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('9:30-10:00'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('10:00-10:30'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('10:30-11:00'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('11:00-11:30'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('11:30-12:00'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('12:00-12:30'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('12:30-1:00'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('1:00-1:30'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Chip(
                        label: Text('1:30-2:00'),
                        labelStyle: TextStyle(
                            fontSize: 30, color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //   Positioned(

                // child: InkWell(
                //   onTap: () {
                //      getCurrentLocation();
                //   },
                // child: Icon(
                //   Icons.location_on,
                //   color:Colors.green,
                //   size: 30.0,
                // ),
                // ),
                // ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    prefixIcon: IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () {
                          getCurrentLocation();
                        }),
                    hintMaxLines: 3,
                    hintText: locationMessage,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),

                //),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      var file = File(_imageFile.path);
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('user_image')
                          .child(_imageFile.path);
                      await ref.putFile(file);
                      final url = await ref.getDownloadURL();
                      if (_formkey.currentState.validate()) {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                            content: Text('Your Restaurant is Registered')));
                        await FirebaseFirestore.instance
                            .collection('AllCategory')
                            .doc(widget.categoryName)
                            .collection('Restrants')
                            .doc(_namecontroller.text)
                            .set({
                          'name': _namecontroller.text
                                  .substring(0, 1)
                                  .toUpperCase() +
                              _namecontroller.text.substring(1),
                          'capitalizedFirstCharcterOfName': _namecontroller.text
                              .substring(0, 1)
                              .toUpperCase(),
                          'image_url': url,
                          'description': _descontroller.text,
                          'numberOftable': _numoftable.text,
                          'latitude': lat,
                          'longtuide': long,
                        });
                      }
                      if (!_formkey.currentState.validate()) {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'Please Fill Your Information Compelete')));
                      }
                    },
                    color: Colors.green,
                    child: Text(
                      'Add Restaurant',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Icon(Icons.location_on ,
      //     size:46.0 ,
      //     color:Colors.red
      //     ),
      //     SizedBox(height:10.0),
      //     Text("Get user Location",
      //     style: TextStyle(
      //       fontSize: 26.0,
      //       fontWeight: FontWeight.bold
      //       ),
      //     ),
      //     SizedBox(height:20.0
      //     ),
      //      Text(locationMessage),

      //     FlatButton(
      //       onPressed: () {
      //         getCurrentLocation();
      //       },
      //       color: Colors.red,
      //        child: Text("Get Current Location",
      //        style: TextStyle(
      //          color:Colors.white
      //        ),
      //        ),
      //      ),

      //   ],
      // ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage:
                _imageFile == null ? null : FileImage(File(_imageFile.path)),
            backgroundColor: Colors.grey[200],
          ),
          Positioned(
            bottom: 20.0,
            right: 5.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.green,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
