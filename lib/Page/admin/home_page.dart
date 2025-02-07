import 'package:flutter/material.dart';
import 'package:smart_education_app/Page/admin/enroll_university.dart';
import 'package:smart_education_app/Page/admin/signup_body.dart';
import 'package:smart_education_app/Page/admin/status_body.dart';

import '../../Widget/smart_drawer.dart';
import '../login_page.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int selected_screen = 0;
  List <Widget> screen = [
    status(),
    signup(),
    enroll()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context)=>IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu)),),
        title: Text("A New Beginning")
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer Header with Gradient Background
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/apple_logo3.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hello Teacher!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SmartDrawer(
                    icon: Icons.person,
                    text: "Student Status",
                    onTap: (){
                      setState(() {
                        selected_screen = 0;
                        Navigator.pop(context);
                      });
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.school,
                    text: "New Student Sign up",
                    onTap: (){
                      setState(() {
                        selected_screen = 1;
                        Navigator.pop(context);
                      });
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.info,
                    text: "Admission Details",
                    onTap: (){
                      setState(() {
                        selected_screen = 2;
                        Navigator.pop(context);
                      });
                    },
                  ),
                  Divider(),
                  SmartDrawer(
                    icon: Icons.logout,
                    text: "Log Out",
                    color: Colors.red,
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Logged out!", style: TextStyle(color: Colors.white),)
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        body: SingleChildScrollView(child: screen[selected_screen]),
    );
  }
}
