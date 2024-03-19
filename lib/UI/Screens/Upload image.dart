import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petshop/Components/Bottom_Nav_Bar.dart';
import 'package:petshop/UI/Screens/notificationScreen.dart';

import '../../Api/Notification_Services.dart';
import '../../utils/utils.dart';
import 'details.dart';

class UploadImage extends StatefulWidget {
  final String title;
  final String age;
  final String breed;
  final String weight;
  final String place;
  final String phone;
  final String description;
  final String category;
  final bool fav;

  const UploadImage({
    super.key,
    required this.title,
    required this.age,
    required this.breed,
    required this.weight,
    required this.place,
    required this.phone,
    required this.description,
    required this.category,
    required this.fav,
  });

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // final titleController = TextEditingController();
  // final ageController = TextEditingController();
  // final breedController = TextEditingController();
  // final weightController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('no image picked');
        }
      }
    });
  }

  String newUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload picture',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF005061),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color(0x3895BDC6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: _image != null
                        ? Image.file(
                            _image!.absolute,
                          )
                        : const Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Color(0xFF7DAEB8),
                            size: 50,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/image/${DateTime.now().millisecondsSinceEpoch}');
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);
                  String? id = DateTime.now().millisecondsSinceEpoch.toString();

                  Future.value(uploadTask).then((value) async {
                    newUrl = await ref.getDownloadURL();
                    fireStore
                        .collection(auth.currentUser!.email.toString())
                        .doc(id)
                        .set({
                      'id': id,
                      'title': widget.title,
                      'age': widget.age,
                      'breed': widget.breed,
                      'weight': widget.weight,
                      'gender': dropdownValue,
                      'place': widget.place,
                      'phone': widget.phone,
                      'description': widget.description,
                      'url': newUrl,
                      'category': widget.category
                    }).then((value) {
                      setState(() {
                        selectedIndex = 0;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const BottomNavBar()));
                      Utils().toastMessage('Submitted');

                      NotificationServices()
                          .getDeviceToken()
                          .then((value) async {
                        var data = {
                          "to": value.toString(),
                          "notification": {
                            "title": "New pet added",
                            "body": "explore new items",
                            "description": widget.description,
                            "place": widget.place,
                            "url": newUrl,
                            "category": widget.category
                          },
                          "android": {
                            "notification": {
                              "notification_count": 1,
                            },
                          },
                          "data": {"type": "uploaded", "id": "1234"}
                        };

                        await http.post(
                            Uri.parse('https://fcm.googleapis.com/fcm/send'),
                            body: jsonEncode(data),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                              'Authorization':
                                  'key=AAAAcQw2nwk:APA91bEgrOp1QgB1iftG7c-wilw11OgitzGynbDZLKqmJWYfxTehM5dPTha3pqVJuFK8fNjB6-g2gwawKB5j7V-Nd3JOgVk3HQFNMyxsIW1Y5AC5Dh2sOmUQGJ7pm5YWSbCIqAqZpqXm'
                            }).then((value) {
                          if (kDebugMode) {
                            print(value.body.toString());
                          }
                        }).onError((error, stackTrace) {
                          if (kDebugMode) {
                            print(error);
                          }
                        });
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  });
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E697C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0xFFA4B9BE),
                        blurRadius: 8,
                        offset: Offset(2, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
