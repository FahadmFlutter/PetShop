import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/Bottom_Nav_Bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  size: 15,
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0x3895BDC6),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                decoration: InputDecoration(
                    suffix: const SizedBox(
                      width: 10,
                    ),
                    prefix: const SizedBox(
                      width: 10,
                    ),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: const Color(0xFFA0A0A0),
                    ),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BottomNavBar()));
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
      ),
    );
  }
}
