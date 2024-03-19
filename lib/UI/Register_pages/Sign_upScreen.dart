import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/submitButton.dart';
import '../../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
bool isVisible=true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: Color(0xFFA0A0A0)),
                  )
                ],
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/signUp.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Create Your Account',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 25,
                  color: Color(0xFF0E697C),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 320,
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x49000000),
                      blurRadius: 20,
                      offset: Offset(4, 0),
                      spreadRadius: -15,
                    )
                  ],
                ),
                child: SizedBox(
                    height: 45,
                    width: 320,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: userController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'User name',
                          hintStyle: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            color: Color(0xFF7DAEB8),
                            fontWeight: FontWeight.w300,
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xFF7DAEB8),
                          )),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 320,
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x49000000),
                      blurRadius: 20,
                      offset: Offset(4, 0),
                      spreadRadius: -15,
                    )
                  ],
                ),
                child: SizedBox(
                    height: 45,
                    width: 320,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email ID',
                          hintStyle: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            color: Color(0xFF7DAEB8),
                            fontWeight: FontWeight.w300,
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: Color(0xFF7DAEB8),
                          )),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 320,
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x49000000),
                      blurRadius: 20,
                      offset: Offset(4, 0),
                      spreadRadius: -15,
                    )
                  ],
                ),
                child: SizedBox(
                    height: 45,
                    width: 320,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: isVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          color: Color(0xFF7DAEB8),
                          fontWeight: FontWeight.w300,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_open_rounded,
                          color: Color(0xFF7DAEB8),
                        ),
                        suffixIcon:GestureDetector(onTap: (){
                          setState(() {
                            isVisible=!isVisible;
                          });
                        },
                          child: isVisible==true? Icon(
                            Icons.visibility_off_outlined,
                            color: Color(0xFF7DAEB8),
                          )
                        : Icon(
                          Icons.visibility_outlined,
                          color: Color(0xFF7DAEB8),
                        )),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
              ),
              SubmitButton(
                title: 'SIGN UP',
                onTap: () {

                    print("hello");
                    // setState(() {
                    //   loading=true;
                    // });
                    _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text).then((value){
                      Navigator.pop(context);
                      Utils().toastMessage('user registered');
                      // setState(() {
                      //   loading=false;
                      // });

                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                      // setState(() {
                      //   loading=false;
                      // });
                    });}

              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.spaceGrotesk(
                      color: Color(0xFF484747),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.spaceGrotesk(
                        color: Color(0xFF0E697C),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
