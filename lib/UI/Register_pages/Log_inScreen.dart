import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petshop/UI/Register_pages/Forgote_password.dart';
import '../../Components/Bottom_Nav_Bar.dart';
import '../../Components/submitButton.dart';
import '../../utils/utils.dart';
import 'LoginWithPhone.dart';
import 'Sign_upScreen.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      setState(() {
        selectedIndex = 0;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => BottomNavBar()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
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
              SizedBox(height: 20,),
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/login.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Time to spread your love',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  color: Color(0xFF080808),
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign In',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 25,
                  color: Color(0xFF0E697C),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'E-mail',
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
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: isVisible == true
                                      ? Icon(
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> ForgotPassword()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot your password?',
                      style: GoogleFonts.spaceGrotesk(
                        color: Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SubmitButton(
                title: 'LOG IN',
                onTap: () {
                  if (_formKey.currentState!.validate()){
                    login();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Or Sign up using',
                  style: GoogleFonts.spaceGrotesk(
                    color: Color(0xFFA0A0A0),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInwithGoogle();
                    },
                    child: SizedBox(
                        height: 37,
                        width: 37,
                        child: Image.asset('assets/google.png')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginWithPhone()));
                    },
                    child: SizedBox(
                        height: 37,
                        width: 37,
                        child: Icon(
                          Icons.call,
                          color: Colors.green,
                          size: 33,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: GoogleFonts.spaceGrotesk(
                      color: Color(0xFF484747),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Text(
                      'Create',
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

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      setState(() {
        selectedIndex = 0;
      });
      await _auth.signInWithCredential(credential).then((value) =>
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BottomNavBar())));
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
    return null;
  }
}
