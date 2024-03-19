import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/Bottom_Nav_Bar.dart';

class NewNotie extends StatefulWidget {
  final String title;
  final String body;

  const NewNotie({super.key, required this.title, required this.body});

  @override
  State<NewNotie> createState() => _NewNotieState();
}

class _NewNotieState extends State<NewNotie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 250,
              child: Image.asset('assets/login.png'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            widget.body,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () {

              setState(() {
                 selectedIndex = 0;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const BottomNavBar()));
            },
            child: Text(
              'Explore',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                color: const Color(0xFF0E697C),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
