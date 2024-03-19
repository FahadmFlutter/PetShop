import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SubmitButton({super.key, required this.title,  required this.onTap});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 135,
        height: 40,
        decoration: ShapeDecoration(
          color: Color(0xFF0E697C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x470D687C),
              blurRadius: 4,
              offset: Offset(3, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Text(
            (title),
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 0.72,
            ),
          ),
        ),
      ),
    );
  }
}
