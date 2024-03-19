import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/UI/Screens/details.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

List<String> img = [
  'assets/cat.png',
  'assets/dog.png',
  'assets/bird.png',
  'assets/fish.png',
];
List<String> text = [
  "Cat",
  "Dog",
  "Bird",
  "Fish",
];


class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(
            'Choose your category',
            style: GoogleFonts.spaceGrotesk(
              color: Color(0xFF0E697C),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: GridView.count(
                  childAspectRatio: (10/10),
                  // childAspectRatio: (180 (item width) / 250 (item Height)),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  children:
                   List.generate(img.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> Details(category: text[index],)));
                      },
                      child: Container(
                         height: 100,width: 100,
                         decoration: BoxDecoration(
                           color: Color(0x3895BDC6),
                           borderRadius: BorderRadius.circular(15)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(30.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Image.asset(img[index],height: 50,width: 50,),
                               SizedBox(height: 20,),
                               Text(text[index],style: GoogleFonts.spaceGrotesk(
                                 color: Colors.black,
                                 fontSize: 16,
                                 fontWeight: FontWeight.w300,))
                             ],
                           ),
                         ),
                       ),
                    );
                   })
                ))
          ],
        ),
      ),
    );
  }
}
