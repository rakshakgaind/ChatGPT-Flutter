import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_chat_project/screens/chat_screen.dart';
import 'package:new_chat_project/screens/crousal_pages/pages.dart';
import 'package:new_chat_project/screens/crousal_pages/pages3.dart';

import 'crousal_pages/page2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

PageController controller = PageController();
final List<Widget> _list = <Widget>[
  Center(
      child: Pages(
    text: "Page One",
  )),
  Center(
      child: Pages2(
    text: "Page Three",
  )),
  Center(
      child: Pages3(
    text: "Page Four",
  ))
];
int currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  static const appThemeColor = Color(0xFFDFEFED);
  static const dotColor = Color(0xFF10A37F);
  static Color buttonGradient1 = const Color(0xFF4FA599).withOpacity(0.86);
  static Color buttonGradient2 = const Color(0xFF027766).withOpacity(0.86);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appThemeColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "assets/images/Vector.png",
                            ),
                            radius: 42,
                          ),
                        ),
                        Text("Welcome to",
                            style: GoogleFonts.dmSans(fontSize: 32,fontWeight: FontWeight.w700)),
                        Text(
                          "ChatGPT",
                           style: GoogleFonts.dmSans(fontSize: 32,fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Ask anything, get your answer",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: PageView(
                      allowImplicitScrolling: true,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      onPageChanged: (num) {
                        setState(() {
                          currentIndex = num;
                        });
                      },
                      children: _list,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: DotsIndicator(
                      dotsCount: _list.length,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        sizes: [
                          const Size(28.0, 2.0),
                          const Size(28.0, 2.0),
                          const Size(28.0, 2.0),
                        ],
                        shape: const Border(),
                        activeColor: dotColor,
                        size: const Size.square(4.0),
                        activeSize: const Size(28.0, 2.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              height: 57,
              width: 142,
              child: FloatingActionButton(
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          buttonGradient1,
                          buttonGradient2,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            "assets/images/Vector (3).png",
                            width: 18,
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ), //child widget inside this button
                onPressed: () {
                  if (currentIndex == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ));
                  }
                  controller.nextPage(
                      duration: const Duration(microseconds: 1),
                      curve: Curves.ease);
                },
              ),
            )));
  }
}
