import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/UI/Screens/new%20nofications.dart';

import '../../Api/Notification_Services.dart';
import '../../utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  final String id;

  const NotificationScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _MessageState();
}

final auth = FirebaseAuth.instance;

final searchFilter = TextEditingController();

class _MessageState extends State<NotificationScreen> {
  NotificationServices notificationServices = NotificationServices();

  final editController = TextEditingController();
  final fireStore =
      FirebaseFirestore.instance.collection('notification').snapshots();
  CollectionReference ref =
      FirebaseFirestore.instance.collection('notification');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationServices.requestNotificationPermission();
    // notificationServices.foregroundMessage();
    // notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     print('device token = $value');
    //   }
    //   // send notification from one device to another
    //   notificationServices.getDeviceToken().then((value)async{
    //
    //     var data = {
    //       "to" : value.toString(),
    //
    //       "notification" : {
    //         "title" : "Hello" ,
    //         "body" : "this is Notification" ,
    //       },
    //       "android": {
    //         "notification": {
    //           "notification_count": 1,
    //         },
    //       },
    //       "data" : {
    //         "type" : "chat" ,
    //         "id" : "1234"
    //       }
    //     };
    //
    //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //         body: jsonEncode(data) ,
    //         headers: {
    //           'Content-Type': 'application/json; charset=UTF-8',
    //           'Authorization' : 'key=AAAAcQw2nwk:APA91bEgrOp1QgB1iftG7c-wilw11OgitzGynbDZLKqmJWYfxTehM5dPTha3pqVJuFK8fNjB6-g2gwawKB5j7V-Nd3JOgVk3HQFNMyxsIW1Y5AC5Dh2sOmUQGJ7pm5YWSbCIqAqZpqXm'
    //         }
    //     ).then((value){
    //       if (kDebugMode) {
    //         print(value.body.toString());
    //       }
    //     }).onError((error, stackTrace){
    //       if (kDebugMode) {
    //         print(error);
    //       }
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Notification Screen${widget.id}',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF0E697C),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Column(
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
                        leading: const Icon(Icons.notifications,
                            color: Color(0xFF0E697C)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>  NewNotie(
                                        title: snapshot.data!.docs[index]['title'].toString(),
                                        body: snapshot.data!.docs[index]['body'].toString(),
                                      )));

                          ref.doc(snapshot.data!.docs.toString()).delete().then((value){
                            Utils().toastMessage('data updated');
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });

                          // ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                        },
                        title: Text(
                          snapshot.data!.docs[index]['title'].toString(),
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index]['body'].toString(),
                          style: GoogleFonts.spaceGrotesk(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
