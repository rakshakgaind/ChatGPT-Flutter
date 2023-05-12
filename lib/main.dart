import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chat_project/providers/chat_screen_provider.dart';
import 'package:new_chat_project/screens/chat_screen.dart';
import 'package:new_chat_project/screens/home_screen.dart';
import 'package:new_chat_project/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ChatScreenProvider>(create: (context) => ChatScreenProvider())
  ],
      child: const MyApp()));
}
TextToSpeech tts = TextToSpeech();



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.raleway().fontFamily,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32,fontWeight: FontWeight.w700,color: Colors.black),
          headlineMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
          headlineSmall: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
          bodyLarge: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black),
          bodyMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),
        ),
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
