import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Widget/smart_button.dart';
import 'package:smart_education_app/Widget/smart_dropdowns.dart';
import 'package:smart_education_app/Widget/smart_inforow.dart';
import 'package:smart_education_app/feature/getter_setter.dart';

import '../../firebase/checkID&Pass.dart';
StudentIdentity SI = StudentIdentity();

class user_result extends StatefulWidget {
  const user_result({super.key});

  @override
  State<user_result> createState() => _user_resultState();
}

class _user_resultState extends State<user_result> {
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

  bool isLoading = false;

  Future<void> _refresh() async {
    try{
      int node = SI.getIdentity();
      DataSnapshot snapshot = await database.child("Result/$node/").get();
      DataSnapshot snapshot1 = await database.child("one/$node/").get();
      DataSnapshot snapshot2 = await database.child("two/$node/").get();
      DataSnapshot snapshot3 = await database.child("three/$node/").get();
      DataSnapshot snapshot4 = await database.child("four/$node/").get();
      DataSnapshot snapshot5 = await database.child("five/$node/").get();
      DataSnapshot snapshot6 = await database.child("six/$node/").get();
      DataSnapshot snapshot7 = await database.child("seven/$node/").get();
      DataSnapshot snapshot8 = await database.child("eight/$node/").get();
      DataSnapshot snapshot9 = await database.child("nine/$node/").get();
      DataSnapshot snapshot10 = await database.child("ten/$node/").get();
      if(snapshot.exists) {
        setState(() {
          SI.setResultData(Map<String, dynamic>.from(snapshot.value as Map));
          SI.setOneData(Map<String, dynamic>.from(snapshot1.value as Map));
          SI.setTwoData(Map<String, dynamic>.from(snapshot2.value as Map));
          SI.setThreeData(Map<String, dynamic>.from(snapshot3.value as Map));
          SI.setFourData(Map<String, dynamic>.from(snapshot4.value as Map));
          SI.setFiveData(Map<String, dynamic>.from(snapshot5.value as Map));
          SI.setSixData(Map<String, dynamic>.from(snapshot6.value as Map));
          SI.setSevenData(Map<String, dynamic>.from(snapshot7.value as Map));
          SI.setEightData(Map<String, dynamic>.from(snapshot8.value as Map));
          SI.setNineData(Map<String, dynamic>.from(snapshot9.value as Map));
          SI.setTenData(Map<String, dynamic>.from(snapshot10.value as Map));
        });

        ResultData = SI.getResultData();
        OneData = SI.getOneData();
        TwoData = SI.getTwoData();
        ThreeData = SI.getThreeData();
        FourData = SI.getFourData();
        FiveData = SI.getFiveData();
        SixData = SI.getSixData();
        SevenData = SI.getSevenData();
        EightData = SI.getEightData();
        NineData = SI.getNineData();
        TenData = SI.getTenData();
      }
    }catch(e){
      print("Error in user info");
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh().then((_) {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SmartDropdownController ClassControl = SmartDropdownController();
    return RefreshIndicator(
      onRefresh: _refresh,
      child:isLoading ? SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Overall Result Review", style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-01 GPA: ", value: "${ResultData["one"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-02 GPA: ", value: "${ResultData["two"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-03 GPA: ", value: "${ResultData["three"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-04 GPA: ", value: "${ResultData["four"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-05 GPA: ", value: "${ResultData["five"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-06 GPA: ", value: "${ResultData["six"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-07 GPA: ", value: "${ResultData["seven"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-08 GPA: ", value: "${ResultData["eight"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-09 GPA: ", value: "${ResultData["nine"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "Class-10 GPA: ", value: "${ResultData["ten"]} out of 4.00"),
            SizedBox(height: 10,),
            SmartInfoRow(label: "CGPA: ", value: "${ResultData["CGPA"]} out of 4.00"),
            SizedBox(height: 30,),
            SmartDropdown(labelText: "Result Detail of Class", items: [
              "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"
            ], controller: ClassControl),
            SmartButton(label: "Check Result", onPressed: (){
              if(ClassControl.value.toString() == "One") {
                PreliClassResultPop(context, OneData, "Class - 01 Result");
              }
              else if(ClassControl.value.toString() == "Two") {
                PreliClassResultPop(context, TwoData, "Class - 02 Result");
              }
              else if(ClassControl.value.toString() == "Three") {
                PreliClassResultPop(context, ThreeData, "Class - 03 Result");
              }
              else if(ClassControl.value.toString() == "Four") {
                PreliClassResultPop(context, FourData, "Class - 04 Result");
              }
              else if(ClassControl.value.toString() == "Five") {
                AdvClassResultPop(context, FiveData, "Class - 05 Result");
              }
              else if(ClassControl.value.toString() == "Six") {
                AdvClassResultPop(context, SixData, "Class - 06 Result");
              }
              else if(ClassControl.value.toString() == "Seven") {
                AdvClassResultPop(context, SevenData, "Class - 07 Result");
              }
              else if(ClassControl.value.toString() == "Eight") {
                AdvClassResultPop(context, EightData, "Class - 08 Result");
              }
              else if(ClassControl.value.toString() == "Nine") {
                AdvClassResultPop(context, NineData, "Class - 09 Result");
              }
              else if(ClassControl.value.toString() == "Ten") {
                AdvClassResultPop(context, TenData, "Class - 10 Result");
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please Select Class!", style: TextStyle(color: Colors.red),)
                ));
              }
            },)
          ],
        ),
      ): Container(height: 600, child: Center(child: CircularProgressIndicator())),
    );
  }
}

void PreliClassResultPop(BuildContext context, Map<String, dynamic> data, String ClassDetails) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ClassDetails,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Physical Test: ${data["Physical Test"] ?? "N/A"} out of 4.00"),
            Text("Bangla: ${data["Bangla"] ?? "N/A"} out of 4.00"),
            Text("English: ${data["English"] ?? "N/A"} out of 4.00"),
            Text("Math: ${data["Math"] ?? "N/A"} out of 4.00"),
            Text("Science: ${data["Science"] ?? "N/A"} out of 4.00"),
            Text("Arts: ${data["Arts"] ?? "N/A"} out of 4.00"),
            Text("Computer: ${data["Computer"] ?? "N/A"} out of 4.00"),
            Text("Career: ${data["Career"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 10),
            Text("Great Point Average: ${data["GPA"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
          ],
        ),
      );
    },
  );
}

void AdvClassResultPop(BuildContext context, Map<String, dynamic> data, String ClassDetails) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ClassDetails,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Physical Test: ${data["Physical Test"] ?? "N/A"} out of 4.00"),
            Text("Literature: ${data["Literature"] ?? "N/A"} out of 4.00"),
            Text("English: ${data["English"] ?? "N/A"} out of 4.00"),
            Text("Math: ${data["Math"] ?? "N/A"} out of 4.00"),
            Text("Bangladesh Studies: ${data["Bangladesh Studies"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 10),
            Text("Physics: ${data["Physics"] ?? "N/A"} out of 4.00"),
            Text("Chemistry: ${data["Chemistry"] ?? "N/A"} out of 4.00"),
            Text("Biology: ${data["Biology"] ?? "N/A"} out of 4.00"),
            Text("IT: ${data["IT"] ?? "N/A"} out of 4.00"),
            Text("Architecture: ${data["Architecture"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 10),
            Text("Fine Arts: ${data["Fine Arts"] ?? "N/A"} out of 4.00"),
            Text("Music: ${data["Music"] ?? "N/A"} out of 4.00"),
            Text("Archaeology: ${data["Archaeology"] ?? "N/A"} out of 4.00"),
            Text("Philosophy: ${data["Philosophy"] ?? "N/A"} out of 4.00"),
            Text("Psychology: ${data["Psychology"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 10),
            Text("Finance & Management: ${data["Finance & Management"] ?? "N/A"} out of 4.00"),
            Text("Marketing: ${data["Marketing"] ?? "N/A"} out of 4.00"),
            Text("Accounting: ${data["Accounting"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 10),
            Text("Great Point Average: ${data["GPA"] ?? "N/A"} out of 4.00"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
          ],
        ),
      );
    },
  );
}
