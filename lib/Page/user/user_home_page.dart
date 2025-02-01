import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Page/login_page.dart';
import 'package:smart_education_app/Page/user/user_admission_body.dart';
import 'package:smart_education_app/Page/user/user_info_body.dart';
import 'package:smart_education_app/Page/user/user_result_body.dart';
import 'package:smart_education_app/feature/getter_setter.dart';

import '../../Widget/smart_drawer.dart';
final database = FirebaseDatabase.instance.ref();

class user_home extends StatefulWidget {
  const user_home({super.key});

  @override
  State<user_home> createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  StudentIdentity SI = StudentIdentity();

  Map<String, dynamic> ResultData = {};
  Map<String, dynamic> OneData = {};
  Map<String, dynamic> TwoData = {};
  Map<String, dynamic> ThreeData = {};
  Map<String, dynamic> FourData = {};
  Map<String, dynamic> FiveData = {};
  Map<String, dynamic> SixData = {};
  Map<String, dynamic> SevenData = {};
  Map<String, dynamic> EightData = {};
  Map<String, dynamic> NineData = {};
  Map<String, dynamic> TenData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<void> readData() async {
    try {
      int? node = SI.getIdentity();
      if (node == null) {
        print("Error: Identity is not set.");
        return;
      }

      // List of data nodes to fetch
      List<String> nodeNames = [
        "Result", "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine", "ten"
      ];

      // Map to store fetched data
      Map<String, Map<String, dynamic>> fetchedData = {};

      // Fetch all data asynchronously
      for (String nodeName in nodeNames) {
        DataSnapshot snapshot = await database.child("$nodeName/$node/").get();
        if (snapshot.exists) {
          fetchedData[nodeName] = Map<String, dynamic>.from(snapshot.value as Map);
        }
      }

      // Update state once after all data is fetched
      setState(() {
        if (fetchedData.containsKey("Result")) {
          ResultData = fetchedData["Result"]!;
          SI.setResultData(ResultData);
        }
        if (fetchedData.containsKey("one")) {
          OneData = fetchedData["one"]!;
          SI.setOneData(OneData);
        }
        if (fetchedData.containsKey("two")) {
          TwoData = fetchedData["two"]!;
          SI.setTwoData(TwoData);
        }
        if (fetchedData.containsKey("three")) {
          ThreeData = fetchedData["three"]!;
          SI.setThreeData(ThreeData);
        }
        if (fetchedData.containsKey("four")) {
          FourData = fetchedData["four"]!;
          SI.setFourData(FourData);
        }
        if (fetchedData.containsKey("five")) {
          FiveData = fetchedData["five"]!;
          SI.setFiveData(FiveData);
        }
        if (fetchedData.containsKey("six")) {
          SixData = fetchedData["six"]!;
          SI.setSixData(SixData);
        }
        if (fetchedData.containsKey("seven")) {
          SevenData = fetchedData["seven"]!;
          SI.setSevenData(SevenData);
        }
        if (fetchedData.containsKey("eight")) {
          EightData = fetchedData["eight"]!;
          SI.setEightData(EightData);
        }
        if (fetchedData.containsKey("nine")) {
          NineData = fetchedData["nine"]!;
          SI.setNineData(NineData);
        }
        if (fetchedData.containsKey("ten")) {
          TenData = fetchedData["ten"]!;
          SI.setTenData(TenData);
        }
      });

    } catch (e) {
      print("Error fetching data: $e");
    }
  }



  int selected_screen = 0;
  List <Widget> screen = [
    user_info(),
    user_result(),
    user_admission()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (context)=>IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu)),),
          title: Center(child: SizedBox(child: Image(image: AssetImage("assets/book_logo.png")), height: 60,)),
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
                    backgroundImage: AssetImage("assets/apple_logo1.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Back!",
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
                    text: "Bio Data",
                    onTap: (){
                      setState(() {
                        selected_screen = 0;
                      });
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.school,
                    text: "Your Result",
                    onTap: (){
                      setState(() {
                        selected_screen = 1;
                      });
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.info,
                    text: "Admission Details",
                    onTap: (){
                      setState(() {
                        selected_screen = 2;
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
