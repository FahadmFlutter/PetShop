import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petshop/Components/submitButton.dart';

import '../../utils/utils.dart';
import 'Verification.dart';


class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {


  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('Login with Phone number',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
            SizedBox(height: 50,),
            SizedBox(
              height: 50, width: 300,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneNumberController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone,color: Colors.deepPurple,),
                    hintText: '+91 9876543210'
                ),
              ),
            ),
            SizedBox(height: 50,),
            SubmitButton(title: 'Verify',
              onTap: () {
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){

                  },
                  verificationFailed: (e){
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Verification(verificationId: verificationId,)));
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                  });
            },
            )
          ],
        ),
      ),
    );
  }
}
