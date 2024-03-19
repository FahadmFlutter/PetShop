import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/UI/Screens/upload%20image.dart';

class Details extends StatefulWidget {
  final String category;
  const Details({super.key,required this.category});

  @override
  State<Details> createState() => _DetailsState();
}


String dropdownValue = 'Male';
var items = [
  'Male',
  'Female',
];



class _DetailsState extends State<Details> {
  final titleController = TextEditingController();
  final ageController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();
  final genderController = TextEditingController();
  final placeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Include some details',
          style: GoogleFonts.spaceGrotesk(
            color: Color(0xFF005061),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Center(
              child: SizedBox(
                  height: 50,width: 300,
                  child: TextFormField(
                    textInputAction:TextInputAction.next,
                    controller: titleController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Name',
                    ),
                  )),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                      height: 50,width: 140,
                      child: TextFormField(
                        textInputAction:TextInputAction.next,
                        controller: ageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Age',
                        ),
                      )),
                ),
                Center(
                  child: SizedBox(
                      height: 50,width: 140,
                      child: TextFormField(
                        textInputAction:TextInputAction.next,
                        controller: weightController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Weight',
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: SizedBox(
                  height: 50,width: 300,
                  child: TextFormField(
                    textInputAction:TextInputAction.next,
                    controller: breedController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: 'Breed',
                    ),
                  )),
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                height: 50,width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:Border.all(
                        color: Colors.grey.shade600
                    )
                ),
                child: DropdownButton<String>(

                  style: TextStyle(color: Colors.grey[700],fontSize: 16,fontWeight: FontWeight.w500),
                  padding: EdgeInsets.only(left: 12),
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      print(dropdownValue);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: SizedBox(
                  height: 50,width: 300,
                  child: TextFormField(
                    textInputAction:TextInputAction.next,
                    controller: placeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: 'Place',
                    ),
                  )),
            ),
            SizedBox(height: 10,),
            Center(
              child: SizedBox(
                  height: 50,width: 300,
                  child: TextFormField(
                    textInputAction:TextInputAction.next,
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: 'Contact number',
                    ),
                  )),
            ),
            SizedBox(height: 10,),
            Center(
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    textInputAction:TextInputAction.done,
                    maxLines: 3,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: 'description',
                    ),
                  )),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> UploadImage(
                  title: titleController.text.toString(),
                  age: ageController.text.toString(),
                  breed: breedController.text.toString(),
                  weight: weightController.text.toString(),
                  place:  placeController.text.toString(),
                  phone: phoneNumberController.text.toString(),
                  description: descriptionController.text.toString(),
                  category: widget.category,
                  fav: false,


                )));
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF0E697C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
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
                    'Next',
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

    );
  }
}
