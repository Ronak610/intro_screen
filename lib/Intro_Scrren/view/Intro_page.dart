import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intro_Page extends StatefulWidget {
  const Intro_Page({Key? key}) : super(key: key);

  @override
  State<Intro_Page> createState() => _Intro_PageState();
}

class _Intro_PageState extends State<Intro_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                image: Image.asset("aseets/images/step-one.png"),
                title: "Farm Driving",
                body: "there are all kinds of equipment to "
                    "build your farm better harvest"),
            PageViewModel(
              title: "Plant Growing",
              body: "Be part of the agriculture and gives"
                  "your team the power you need to"
                  "do your best",
              image: Image.asset("aseets/images/step-two.png"),
            ),
            PageViewModel(
                image: Image.asset("aseets/images/step-three.png"),
                title: "Fast Harvesting",
                body: "Your will be proud to be part of "
                    "agriculture and it's harvest"),
          ],
          showDoneButton: true,
          onDone: () {
            Navigator.pop(context);
          },
          done: Text("Done",  style: TextStyle(color: Colors.black45, fontSize: 25),),
          showNextButton: true,
          next: Text("Next",  style: TextStyle(color: Colors.black45, fontSize: 25),),
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: TextStyle(color: Colors.black45, fontSize: 25),
          ),

        ),
      ),
    );
  }
}
