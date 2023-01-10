import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_scrren/Intro_Scrren/view/Intro_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Intro_Page(),
      },
    ),
  );
}
