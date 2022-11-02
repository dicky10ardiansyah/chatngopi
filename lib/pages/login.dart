import 'package:chatngopi/widgets/custombutton.dart';
import 'package:chatngopi/widgets/customtextinput.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatterLogin extends StatefulWidget {
  @override
  _ChatterLoginState createState() => _ChatterLoginState();
}

class _ChatterLoginState extends State<ChatterLogin> {
  String email;
  String password;
  bool loggingin = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loggingin,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'heroicon',
                    child: Icon(
                      Icons.spa,
                      size: 120,
                      color: Colors.brown[600],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Hero(
                    tag: 'HeroTitle',
                    child: Text(
                      'ChatNgopi',
                      style: TextStyle(
                          color: Colors.brown[600],
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  // Text(
                  //   "World's most private chatting app".toUpperCase(),
                  //   style: TextStyle(
                  //       fontFamily: 'Poppins',
                  //       fontSize: 12,
                  //       color: Colors.brown),
                  // ),
                  CustomTextInput(
                    hintText: 'Masukkan Email',
                    leading: Icons.mail,
                    obscure: false,
                    keyboard: TextInputType.emailAddress,
                    userTyped: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Kata sandi',
                    leading: Icons.lock,
                    obscure: true,
                    userTyped: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'loginbutton',
                    child: CustomButton(
                      text: 'login',
                      accentColor: Colors.white,
                      mainColor: Colors.brown,
                      onpress: () async {
                        if (password != null && email != null) {
                          setState(() {
                            loggingin = true;
                          });
                          try {
                            final loggedUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (loggedUser != null) {
                              setState(() {
                                loggingin = false;
                              });
                              Navigator.pushNamed(context, '/chat');
                            }
                          } catch (e) {
                            setState(() {
                              loggingin = false;
                            });
                            EdgeAlert.show(context,
                                title: 'Login Gagal',
                                description: e.toString(),
                                gravity: EdgeAlert.BOTTOM,
                                icon: Icons.error,
                                backgroundColor: Colors.brown[600]);
                          }
                        } else {
                          EdgeAlert.show(context,
                              title: 'Uh oh!',
                              description:
                                  'Tolong masukkan email dan password.',
                              gravity: EdgeAlert.BOTTOM,
                              icon: Icons.error,
                              backgroundColor: Colors.brown[600]);
                        }
                        // Navigator.pushReplacementNamed(context, '/chat');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: Text(
                        'atau buat akun baru',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.brown),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Hero(
                    tag: 'footer',
                    child: Text(
                      'Made by DickyArdiansyah',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
