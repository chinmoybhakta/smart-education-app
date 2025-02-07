import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Widget/smart_clock.dart';
import 'package:smart_education_app/Widget/smart_inforow.dart';
import 'package:smart_education_app/feature/getter_setter.dart';

import '../../firebase/checkID&Pass.dart';

class user_info extends StatefulWidget {

  @override
  State<user_info> createState() => _user_infoState();
}

class _user_infoState extends State<user_info> {
  StudentIdentity SI = StudentIdentity();
  Map<String, dynamic> StudentData = {};
  Map<String, dynamic> StudentResult = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readData().then((_) {
      setState(() {
        isLoading = true;
      });
    });
  }

  //READ
  Future<void> readData() async{
    try{
      int node = SI.getIdentity();
      DataSnapshot snapshot = await database.child("Student/$node/").get();
      DataSnapshot snapshot0 = await database.child("Result/$node/").get();
      if(snapshot.exists && snapshot0.exists) {
        setState(() {
          StudentData = Map<String, dynamic>.from(snapshot.value as Map);
          StudentResult = Map<String, dynamic>.from(snapshot0.value as Map);
          SI.setData(StudentData);
        });
      }
    }catch(e){
      print("Error in user info");
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: readData,
      child: isLoading ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartInfoRow(label: "👋 Hello,", value: StudentData["Name"], isBold: true, fontSize: 22),
          SizedBox(height: 15),
          SmartInfoRow(label: "🎂 Date of Birth:", value: StudentData["Birthday"]),
          SmartInfoRow(label: "📞 Contact:", value: StudentData["Contact"]),
          SmartInfoRow(label: "📧 E-mail:", value: StudentData["E-mail"]),
          SmartInfoRow(label: "📚 Favourite Subject:", value: StudentData["Favourite Subject"]),
          SmartInfoRow(label: "🎨 Hobby:", value: StudentData["Hobby"]),
          SmartInfoRow(label: "🏫 Class:", value: "You are now in Class ${StudentData["Class"]}"),
          SizedBox(height: 20),
          SizedBox(height: 100),
          SmartClock(size: 150),
          SizedBox(height: 15),
          Text(
            "⏳ Your time is ticking...",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),),
          SizedBox(height: 100),
          (StudentResult["eligible"] != "") ? SmartInfoRow(label: "Congratulation!\nYou are eligible for ", value: StudentResult["eligible"],
              isBold: true, fontSize: 22
          ) : Text(""),
        ],
      ) : Container(height: 600,child: Center(child: CircularProgressIndicator())),
    );
  }
}


//Array--->  int x[10] = {1, 2, 3, 4};
//List---> List<int> x = [1, 2, 4];
//Map--->  Map <String, int> x = {"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50};
//List Map --> List<Map<String, int>> x = [{"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50}, {"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50}];