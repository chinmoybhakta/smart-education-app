import 'dart:async';

import 'package:flutter/material.dart';

import 'login_page.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _homeState();
}

class _homeState extends State<splash> {
  List <String> apple = ["assets/apple_logo1.png", "assets/apple_logo2.png", "assets/apple_logo3.png"];
  String book = "assets/book_logo.png";
  int selected_item = 0;
  @override
  void initState() {
    Timer(Duration(seconds: 2), (){
      setState(() {
        selected_item = 1;
      });
    });
    Timer(Duration(seconds: 4), (){
      setState(() {
        selected_item = 2;
      });
    });
    Timer(Duration(seconds: 6), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            SizedBox(child: Image.asset(apple[selected_item]), height: 100,),
            SizedBox(child: Image.asset(book), height: 250),
          ],
        ),
      ),
    );
  }
}
