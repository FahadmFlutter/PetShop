import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:petshop/UI/Screens/Favorites.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../Components/Bottom_Nav_Bar.dart';
import '../../utils/utils.dart';
import 'Home.dart';


class ProductPage extends StatefulWidget {
  final String title;
  final String age;
  final String breed;
  final String weight;
  final String place;
  final String phone;
  final String img;
  final String description;
  final String gender;
  final String id;


  const ProductPage({
    super.key,
    required this.title,
    required this.age,
    required this.breed,
    required this.weight,
    required this.place,
    required this.phone,
    required this.img,
    required this.description,
    required this.gender,
    required this.id,


  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

// List<bool> liked = List.generate( 1000, (index) => false);
  bool liked = false;
  final fireStore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const BottomNavBar()));
                },
                child: const CircleAvatar(
                    backgroundColor: Color(0x6695BDC6),
                    radius: 20,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFF0E697C),
                    )),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSlideshow(
                height: 300,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                isLoop: true,
                autoPlayInterval: 0,
                children: [
                  Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  )
                ],
              ),
              // Container(
              //   height: 300,
              //   width: double.infinity,
              //   color: Colors.green[50],
              //   child: Image.network(
              //     widget.img,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          Text(widget.title,
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF005061),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.84,
                                height: 1,
                              )),
                          widget.gender.toString()=="Male" ? const Icon(Icons.male_rounded,color: Colors.blueAccent,size: 30,):const Icon(Icons.female_rounded,color: Colors.pinkAccent,size: 30 ,),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          liked = !liked;
                        });
                        if (liked){
                          fireStore.collection(user).doc(widget.id).collection('Fav').doc(widget.id).set({'liked' : liked, 'id' : widget.id, 'img': widget.img , 'title': widget.title})
                          // ref.doc(user).collection('fav').doc().set({'liked' : liked, 'id' : widget.id}).
                          .then((value){
                            Utils().toastMessage('added to favorites');}).
                          onError((error, stackTrace){Utils().toastMessage(error.toString());});
                        }else{
                          fireStore.collection(user).doc(widget.id).collection('Fav').doc(widget.id).delete().
                            then((value){
                              Utils().toastMessage('removed from favorites');}).
                            onError((error, stackTrace){Utils().toastMessage(error.toString());});
                        }

                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0x6695BDC6),
                        radius: 20,
                        child: Icon(
                            liked ? Icons.favorite : Icons.favorite_border,
                            color: const Color(0xFF0E697C)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF7DAEB8),
                    ),
                    Text(widget.place,
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF7DAEB8),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.84,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    decoration: ShapeDecoration(
                      color: const Color(0x3895BDC6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Age',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF6A6969),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.84,
                              )),
                          Text(widget.age,
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF0E697C),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 0.8,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 70,
                    decoration: ShapeDecoration(
                      color: const Color(0x3895BDC6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Text('Breed',
                                style: GoogleFonts.spaceGrotesk(
                                  color: const Color(0xFF6A6969),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.84,
                                )),
                          ),
                          Text(widget.breed,
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF0E697C),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 0.8,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 70,
                    decoration: ShapeDecoration(
                      color: const Color(0x3895BDC6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Weight',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF6A6969),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.84,
                              )),
                          Text(widget.weight,
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF0E697C),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 0.8,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 74,
                          height: 74,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF0E697C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 190,
                              child: Text(
                                widget.title,
                                style: GoogleFonts.spaceGrotesk(
                                  color: const Color(0xFF0E697C),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                            ),
                            Text(
                              'Pet Owner',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF7A7A7A),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () async {
                          Uri phone = Uri.parse('tel:${widget.phone}');
                          if (await canLaunchUrl(phone)) {
                            await launchUrl(phone);
                          } else {
                            throw 'Could not launch $phone';
                          }
                        },
                        child: const Icon(
                          Icons.call_rounded,
                          color: Color(0xFF0E697C),
                          size: 35,
                        ))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  widget.description,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF484646),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.70,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await shareImageFromUrl(
                        phone: widget.phone, imageUrl: widget.img);
                  },

                  /* share plus */
                  // onTap: () async{
                  //   final imgUrl =widget.img;
                  //   await Share.share(imgUrl);
                  // },

                  /* WhatsappShare */
                  // onTap: () async{
                  //   await WhatsappShare.shareFile(
                  //      // Replace with your desired URL
                  //     phone: '91${widget.phone}', filePath: [], // Replace with the recipient's phone number
                  //     // Add file paths
                  //   );
                  // },

                  /* url_launcher */
                  // onTap: (){
                  //  _launchWhatsApp(widget.phone,);
                  //
                  // },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 300,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0E697C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
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
                        child: Text('Message',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.20,
                            )),
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
//
// _launchWhatsApp(
//   String phone,
// ) async {
//   String phoneNumber = '+91$phone'; // Change this.
//   const message = 'interested in buying a pet ';
//   const fileUrl =
//       'https://th.bing.com/th/id/OIP.fqjaIVihNHDoHo7LwlWDqwHaE7?w=285&h=190&c=7&r=0&o=5&dpr=1.1&pid=1.7';
//   // Change this.
//
//   final whatsappUrl =
//       'https://wa.me/$phoneNumber?text=${Uri.parse(message)}&file=$fileUrl';
//
//   if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
//     await launchUrl(Uri.parse(whatsappUrl));
//   } else {
//     throw 'Could not launch $whatsappUrl';
//   }
// }

Future<void> shareImageFromUrl(
    {required String phone, required imageUrl}) async {
  final response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;

  final appDir = await getApplicationDocumentsDirectory();
  final imagePath = '${appDir.path}/image.jpg';

  await File(imagePath).writeAsBytes(bytes);


  await WhatsappShare.shareFile(
    phone: '91$phone', // Replace with the recipient's phone number
    filePath: [imagePath], // Path to the downloaded image file
  );


}
