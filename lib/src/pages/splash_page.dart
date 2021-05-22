import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wawa_simi/src/pages/home_page.dart';

class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
  bool showButton = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  Timer startTimer(){
    Duration duration = new Duration(seconds: 5);
    return new Timer(duration,(){
      showButton = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _textoCentral(), //56
              showButton ? Positioned(
                child: Column(
                  children: [
                    _boton1(context), //63
                    _texto1() //80
                  ],
                ),
                right: 60,
                bottom: 50,
              ) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textoCentral(){
  return Container(
    alignment: Alignment.center,
    child: Text('WawaSimi',style: GoogleFonts.actor(fontSize: 45)),
  );
}

Widget _boton1(BuildContext context){
  return GestureDetector(
    onTap: (){
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage())
      );
    },
    child: Container(
      width: 45,
      margin: EdgeInsets.only(bottom:10),
      height: 45,
      child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.indigo),
    ),
  );
}

Widget _texto1(){
  return Text('Go', style: GoogleFonts.actor(fontSize: 18));
}