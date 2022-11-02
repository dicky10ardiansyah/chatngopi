import 'package:chatngopi/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatterHome extends StatefulWidget {
  @override
  _ChatterHomeState createState() => _ChatterHomeState();
}

class _ChatterHomeState extends State<ChatterHome>
    with TickerProviderStateMixin {
  AnimationController mainController;
  Animation mainAnimation;
  @override
  void initState() {
    super.initState();
    mainController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    mainAnimation =
        ColorTween(begin: Colors.deepPurple[900], end: Colors.grey[100])
            .animate(mainController);
    mainController.forward();
    mainController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAnimation.value,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'heroicon',
                  child: Icon(
                    Icons.spa,
                    size: mainController.value * 100,
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
                        color: Colors.brown[200],
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TyperAnimatedTextKit(
                  isRepeatingAnimation: false,
                  speed: Duration(milliseconds: 60),
                  text: ["Chat gratis tanpa mikir".toUpperCase()],
                  textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.brown[600]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Hero(
                  tag: 'loginbutton',
                  child: CustomButton(
                    text: 'Masuk',
                    accentColor: Colors.brown[600],
                    onpress: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: 'signupbutton',
                  child: CustomButton(
                    text: 'Daftar',
                    accentColor: Colors.white,
                    mainColor: Colors.brown[600],
                    onpress: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text('Made by DickyArdiansyah')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
