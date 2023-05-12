import 'package:flutter/material.dart';

class Pages extends StatelessWidget {
  final text;Pages({super.key, this.text,});

  double currentIndexPage=0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                Image.asset("assets/images/Frame (1).png",
                  height: 20,
                  width: 20,
                ),
                 Text("Examples",
                style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50,top: 10),
                  child: Text("Explain quantum computing in simple terms",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50),
                  child: Text("Got any creative ideas for a 10 year old’s birthday?",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),),
            ),
            Padding(
              padding:  const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50),
                  child: Text("How do I make an HTTP request in Javascript?",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),),
            ),




          ]),
    );
  }
}