import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petshop/Components/Bottom_Nav_Bar.dart';

import '../../utils/utils.dart';

class Verification extends StatefulWidget {
  final String verificationId;

  const Verification({super.key, required this.verificationId});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final auth = FirebaseAuth.instance;
  final VerificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  'Verification code',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: VerificationCodeController,
                decoration: const InputDecoration(

                    hintText: '0 0 0 0 0 0'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: VerificationCodeController.text.toString());
                try{
                  await auth.signInWithCredential(credential);
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> BottomNavBar()));
                }catch(e){
                  Utils().toastMessage(e.toString());
                }

                // auth.verifyPhoneNumber(
                //     phoneNumber: PhoneNumberController.text,
                //     verificationCompleted: (_){
                //
                //     },
                //     verificationFailed: (e){
                //       Utils().toastMessage(e.toString());
                //     },
                //     codeSent: (String verificationId, int? token){
                //       Navigator.push(context, MaterialPageRoute(builder: (_)=> Verification(verificationId: verificationId,)));
                //     },
                //     codeAutoRetrievalTimeout: (e){
                //       Utils().toastMessage(e.toString());
                //     });
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('Verify',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
