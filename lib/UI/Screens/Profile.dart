import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';
import '../Register_pages/Log_inScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

List<String> text = [
  "Edit Profile",
  "Notification",
  "Settings & Privacy",
  "Help & Support",
];

List<Widget> icon = [
  Icon(Icons.account_circle_outlined),
  Icon(Icons.notifications_none_rounded),
  Icon(Icons.settings),
  Icon(Icons.support_agent_rounded),
];

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: -170,
            child: CircleAvatar(
              backgroundColor: Color(0xB2D6F3EF),
              radius: 180,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 90,
                ),
                 Center(
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF00B69D),
                    radius: 60,
                    child: CircleAvatar(
                      radius: 53,
                      child: Center(
                        child: Center(
                            child: auth.currentUser!.email==null?  const Icon(
                              Icons.account_circle_outlined,
                              size: 45,
                              color: Color(0xFF95BDC6),
                            ): CircleAvatar(backgroundImage: NetworkImage( auth.currentUser!.photoURL.toString()), radius: 60,)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child:  auth.currentUser!.displayName==null? Text(auth.currentUser!.email.toString(),style: GoogleFonts.spaceGrotesk(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),) :
                    Text(auth.currentUser!.displayName.toString(),style: GoogleFonts.spaceGrotesk(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),)

                  ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: text.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            icon[index],
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              text[index],
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Container(
                    width: 227,
                    height: 52,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF00B69D)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          auth.signOut().then((value) {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => LogIn()));
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        },
                        child: Text(
                          'Logout',
                          style: GoogleFonts.spaceGrotesk(
                            color: Color(0xFF40C8B6),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
