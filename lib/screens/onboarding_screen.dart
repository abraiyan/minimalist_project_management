import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sideappbarui/screens/home_page.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Minimalist ',
                  style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: 'To Do',
                      style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 30),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/onboard_one.png'),
                  ),
                ),
              ),
              Text('A Simple Task Management App\nMade By - AB Raiyan', textAlign: TextAlign.center, style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 18),),
              const SizedBox(height: 20,),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                color: Colors.blueAccent,
                child: Text('Start', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
