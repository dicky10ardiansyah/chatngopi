import 'package:chatngopi/widgets/custombutton.dart';
import 'package:chatngopi/widgets/customtextinput.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatterSignUp extends StatefulWidget {
  @override
  _ChatterSignUpState createState() => _ChatterSignUpState();
}

class _ChatterSignUpState extends State<ChatterSignUp> {
  final _auth = FirebaseAuth.instance;
  String email;
  // String username;
  String password;
  String name;
  bool signingup = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: signingup,
      child: Scaffold(
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
                      color: Colors.brown,
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
                  CustomTextInput(
                    hintText: 'Input nama',
                    leading: Icons.text_format,
                    obscure: false,
                    userTyped: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Masukkan Email',
                    leading: Icons.mail,
                    keyboard: TextInputType.emailAddress,
                    obscure: false,
                    userTyped: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Kata sandi',
                    leading: Icons.lock,
                    keyboard: TextInputType.visiblePassword,
                    obscure: true,
                    userTyped: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'signupbutton',
                    child: CustomButton(
                      onpress: () async {
                        if (name != null && password != null && email != null) {
                          setState(() {
                            signingup = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              UserUpdateInfo info = UserUpdateInfo();
                              info.displayName = name;
                              await newUser.user.updateProfile(info);

                              Navigator.pushNamed(context, '/chat');
                            }
                          } catch (e) {
                            setState(() {
                              signingup = false;
                            });
                            EdgeAlert.show(context,
                                title: 'Daftar Gagal',
                                description: e.toString(),
                                gravity: EdgeAlert.BOTTOM,
                                icon: Icons.error,
                                backgroundColor: Colors.brown[600]);
                          }
                        } else {
                          EdgeAlert.show(context,
                              title: 'Daftar Gagal',
                              description: 'Semua fields harus diisi.',
                              gravity: EdgeAlert.BOTTOM,
                              icon: Icons.error,
                              backgroundColor: Colors.brown[600]);
                        }
                      },
                      text: 'Yuk daftar',
                      accentColor: Colors.white,
                      mainColor: Colors.brown,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'atau langsung login aja',
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
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
