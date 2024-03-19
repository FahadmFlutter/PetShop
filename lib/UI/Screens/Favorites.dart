import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home.dart';


class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}
final fireStore = FirebaseFirestore.instance.collection(user).snapshots();
// final fireStore = FirebaseFirestore.instance.collection('Fav').snapshots();

CollectionReference ref = FirebaseFirestore.instance.collection(user).doc().collection('Fav');

class _FavoritesState extends State<Favorites> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('favorites',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF0E697C),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something else!!!'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.favorite),
                      onTap: () {

                        // ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                      },
                      subtitle: Text(
                        snapshot.data!.docs[index]['title'].toString(),
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      title: Container(
                        height: 50,
                        width: 100,
                        child: Image.network(snapshot.data!.docs[index]['url'],fit: BoxFit.cover,),
                      ),
                      trailing: Icon(Icons.close),
                    );
                  },
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
