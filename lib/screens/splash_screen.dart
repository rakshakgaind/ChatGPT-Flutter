import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chat_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Color buttonGradient1 = const Color(0xFF4FA599).withOpacity(0.86);
Color buttonGradient2 = const Color(0xFF027766).withOpacity(0.86);

newScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
  });
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    newScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              buttonGradient1,
              buttonGradient2,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/chatGptImage.png", height: 100,),
             SizedBox(height: MediaQuery.of(context).size.height/95,),
             Text("ChatGPT", style: GoogleFonts.dmSans(fontSize: 32,fontWeight: FontWeight.w700,color: Colors.white))
          ],
        ),
      ),
    );
  }
}
