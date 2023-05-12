import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pages3 extends StatelessWidget {
  final text;
  Pages3({super.key, this.text,
  });

  double currentIndexPage=0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: [
                Image.asset("assets/images/caution.png",
                  height: 20,
                  width: 20,
                ),
                 Text("Limitations",
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
                  padding: EdgeInsets.only(left: 50,right: 50,top: 10),
                  child: Text("Remembers what user said earlier in the conversation",
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
                  padding: EdgeInsets.only(left: 50,right: 50),
                  child: Text("Allows user to provide follow-up corrections",
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
                  child: Text("Trained to decline inappropriate requests",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),),
            ),
          ]),
    );
  }
}