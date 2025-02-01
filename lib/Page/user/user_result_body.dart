import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Widget/smart_button.dart';
import 'package:smart_education_app/Widget/smart_dropdowns.dart';
import 'package:smart_education_app/Widget/smart_inforow.dart';
import 'package:smart_education_app/feature/getter_setter.dart';
StudentIdentity SI = StudentIdentity();

class user_result extends StatefulWidget {
  const user_result({super.key});

  @override
  State<user_result> createState() => _user_resultState();
}

class _user_resultState extends State<user_result> {
  @override
  Widget build(BuildContext context) {
      Map<String, dynamic> ResultData = SI.getResultData();
      Map<String, dynamic> OneData = SI.getOneData();
      Map<String, dynamic> TwoData = SI.getTwoData();
      Map<String, dynamic> ThreeData = SI.getThreeData();
      Map<String, dynamic> FourData = SI.getFourData();
      Map<String, dynamic> FiveData = SI.getFiveData();
      Map<String, dynamic> SixData = SI.getSixData();
      Map<String, dynamic> SevenData = SI.getSevenData();
      Map<String, dynamic> EightData = SI.getEightData();
      Map<String, dynamic> NineData = SI.getNineData();
      Map<String, dynamic> TenData = SI.getTenData();
    SmartDropdownController ClassControl = SmartDropdownController();
    print(OneData);
    return Column(
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
          if(ClassControl.value.toString() == "Two") {
            PreliClassResultPop(context, TwoData, "Class - 02 Result");
          }
          if(ClassControl.value.toString() == "Three") {
            PreliClassResultPop(context, ThreeData, "Class - 03 Result");
          }
          if(ClassControl.value.toString() == "Four") {
            PreliClassResultPop(context, FourData, "Class - 04 Result");
          }
          if(ClassControl.value.toString() == "Five") {
            AdvClassResultPop(context, FiveData, "Class - 05 Result");
          }
          if(ClassControl.value.toString() == "Six") {
            AdvClassResultPop(context, SixData, "Class - 06 Result");
          }
          if(ClassControl.value.toString() == "Seven") {
            AdvClassResultPop(context, SevenData, "Class - 07 Result");
          }
          if(ClassControl.value.toString() == "Eight") {
            AdvClassResultPop(context, EightData, "Class - 08 Result");
          }
          if(ClassControl.value.toString() == "Nine") {
            AdvClassResultPop(context, NineData, "Class - 09 Result");
          }
          if(ClassControl.value.toString() == "Ten") {
            AdvClassResultPop(context, TenData, "Class - 10 Result");
          }
        },)
      ],
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
