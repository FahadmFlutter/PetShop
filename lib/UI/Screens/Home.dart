import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/Components/Bottom_Nav_Bar.dart';
import 'package:petshop/UI/Screens/Search.dart';
import '../../Api/Notification_Services.dart';
import 'Product page.dart';
import 'notificationScreen.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
final String user = auth.currentUser!.email.toString();



class _HomeState extends State<Home> {


  FirebaseAuth auth = FirebaseAuth.instance;
  final editController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection(user).snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection(user);

  // final fireStoreFav = FirebaseFirestore.instance.collection('pet').doc(id).collection('favo');



NotificationServices  notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child:  CircleAvatar(
                    backgroundColor: Color(0x3895BDC6),
                    radius: 25,
                    child: Center(
                        child: auth.currentUser!.email==null?  Icon(
                      Icons.account_circle_outlined,
                      size: 45,
                      color: Color(0xFF95BDC6),
                    ): CircleAvatar(backgroundImage: NetworkImage( auth.currentUser!.photoURL.toString()), radius: 25,)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi, ',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        auth.currentUser!.displayName==null? Text('Pet Lover',
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),) :
                        Text(auth.currentUser!.displayName.toString(), style: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                    Text(
                      'Discover your new friend',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
             Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const Search()));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0x3895BDC6),
                    radius: 20,
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF0E697C),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const BottomNavBar()));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0x3895BDC6),
                    radius: 20,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFF0E697C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Remove any padding from the ListView.
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF95BDC6),
              ),
              child: Text('Custom Drawer Header'),
            ),

            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item 1 tap.
                // ...
                Navigator.pop(context); // Close the drawer programmatically.
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item 2 tap.
                // ...
                Navigator.pop(context); // Close the drawer programmatically.
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: SizedBox(
          //     height: 60,
          //     width: 500,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(Icons.tune_rounded,color: Color(0xFF0E697C),size: 20,),
          //                 SizedBox(width: 10,),
          //                 Text(
          //                   'Filter',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   'All',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   "assets/dog.png",
          //                   height: 16,
          //                   width: 16,
          //                 ),
          //                 SizedBox(width: 10,),
          //                 Text(
          //                   'Dogs',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   "assets/cat.png",
          //                   height: 16,
          //                   width: 16,
          //                 ),
          //                 SizedBox(width: 10,),
          //                 Text(
          //                   'Cats',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   "assets/bird.png",
          //                   height: 16,
          //                   width: 16,
          //                 ),
          //                 SizedBox(width: 10,),
          //                 Text(
          //                   'Birds',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Container(
          //           decoration: ShapeDecoration(
          //             color: Color(0x3895BDC6),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   "assets/fish.png",
          //                   height: 16,
          //                   width: 16,
          //                 ),
          //                 SizedBox(width: 10,),
          //                 Text(
          //                   'Fishes',
          //                   style: GoogleFonts.spaceGrotesk(
          //                     color: Color(0xFF0E697C),
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          StreamBuilder(
            stream: fireStore,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Something else!!!'),);
              }
              return Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(5),
                  childAspectRatio: (180 / 270),
                  // childAspectRatio: (180 (item width) / 250 (item Height)),
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 7,
                  shrinkWrap: true,
                  children: List.generate(
                      snapshot.data!.docs.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductPage(
                          title:  snapshot.data!.docs[index]['title'].toString(),
                          age:  snapshot.data!.docs[index]['age'].toString(),
                          breed:  snapshot.data!.docs[index]['breed'].toString(),
                          weight:  snapshot.data!.docs[index]['weight'].toString(),
                          place:  snapshot.data!.docs[index]['place'].toString(),
                          phone:  snapshot.data!.docs[index]['phone'].toString(),
                          img: snapshot.data!.docs[index]['url'].toString(),
                          description: snapshot.data!.docs[index]['description'].toString(),
                          gender: snapshot.data!.docs[index]['gender'].toString(),
                          id: snapshot.data!.docs[index]['id'].toString(),
                        )));
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0x3895BDC6),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                children: [
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.docs[index]['url'].toString(),),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    // child: Image.network(snapshot.data!.docs[index]['url'].toString(),),
                                  ),

                                ]
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      snapshot.data!.docs[index]['title'].toString(),
                                      style: GoogleFonts.spaceGrotesk(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  snapshot.data!.docs[index]['gender'].toString()=="Male" ? const Icon(Icons.male_rounded,color: Colors.blueAccent ,):const Icon(Icons.female_rounded,color: Colors.pinkAccent ,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3,left: 15,right: 15,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   snapshot.data!.docs[index]['gender'].toString(),
                                  //   style: GoogleFonts.spaceGrotesk(
                                  //     color: Color(0xFF7A7A7A),
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w300,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 15,
                                  //   child: VerticalDivider(
                                  //     thickness: 2,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   ' | ',
                                  //   style: GoogleFonts.spaceGrotesk(
                                  //     color: Color(0xFF7A7A7A),
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w300,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                    snapshot.data!.docs[index]['place'].toString(),
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFF7A7A7A),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        height: 1,

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  // String id = FirebaseAuth.instance.currentUser!.uid;
}
