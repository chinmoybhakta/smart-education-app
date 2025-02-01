import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Widget/smart_button.dart';
import 'package:smart_education_app/Widget/smart_textfield.dart';
import 'package:smart_education_app/firebase/insert.dart';

import '../../Widget/smart_dropdowns.dart';

class enroll extends StatefulWidget {
  const enroll({super.key});

  @override
  State<enroll> createState() => _admissionState();
}

class _admissionState extends State<enroll> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    TextEditingController InstituteCon = TextEditingController();
    TextEditingController SubjectCon = TextEditingController();
    TextEditingController SeatCon = TextEditingController();
    TextEditingController CGPACon = TextEditingController();
    SmartDropdownController Sub01Con = SmartDropdownController();
    SmartDropdownController Sub02Con = SmartDropdownController();
    SmartDropdownController Sub03Con = SmartDropdownController();
    TextEditingController Sub01GPACon = TextEditingController();
    TextEditingController Sub02GPACon = TextEditingController();
    TextEditingController Sub03GPACon = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text("Enroll a new Institute"),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Institute Name", controller: InstituteCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Subject Name", controller: SubjectCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Available Seats", controller: SeatCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Required CGPA", controller: CGPACon),
          SizedBox(height: 10,),
          SmartDropdown(
              labelText: "Required Subject 01",
              items: const [
                "Physical Test",
                "Bangladesh Studies",
                "Literature",
                "English",
                "Math",
                "Architecture",
                "IT",
                "Physics",
                "Chemistry",
                "Biology",
                "Accounting",
                "Finance & Management",
                "Marketing",
                "Fine Arts",
                "Music",
                "Archaeology",
                "Philosophy",
                "Psychology",
              ],
              controller: Sub01Con),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Required Subject 01 GPA", controller: Sub01GPACon),
          SizedBox(height: 10,),
          SmartDropdown(
              labelText: "Required Subject 02",
              items: const [
                "Physical Test",
                "Bangladesh Studies",
                "Literature",
                "English",
                "Math",
                "Architecture",
                "IT",
                "Physics",
                "Chemistry",
                "Biology",
                "Accounting",
                "Finance & Management",
                "Marketing",
                "Fine Arts",
                "Music",
                "Archaeology",
                "Philosophy",
                "Psychology",
              ],
              controller: Sub02Con),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Required Subject 02 GPA", controller: Sub02GPACon),
          SizedBox(height: 10,),
          SmartDropdown(
              labelText: "Required Subject 03",
              items: const [
                "Physical Test",
                "Bangladesh Studies",
                "Literature",
                "English",
                "Math",
                "Architecture",
                "IT",
                "Physics",
                "Chemistry",
                "Biology",
                "Accounting",
                "Finance & Management",
                "Marketing",
                "Fine Arts",
                "Music",
                "Archaeology",
                "Philosophy",
                "Psychology",
              ],
              controller: Sub03Con),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Required Subject 03 GPA", controller: Sub03GPACon),
          SizedBox(height: 30,),
          SmartButton(label: "Confirm Enroll", onPressed: () {
            if(InstituteCon.text.isEmpty || SubjectCon.text.isEmpty || SeatCon.text.isEmpty || CGPACon.text.isEmpty || Sub01GPACon.text.isEmpty || Sub02GPACon.text.isEmpty || Sub03GPACon.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to Add new versity", style: TextStyle(color: Colors.red),)
              ));
            }
            else {
              Map<String, dynamic> versityData = {
                "institute": InstituteCon.text,  // Fixed spelling mistake
                "subject": SubjectCon.text,
                "seat": int.parse(SeatCon.text),             // Use .text to get value
                "cgpa": double.parse(CGPACon.text),
                "sub01": Sub01Con.value.toString(),
                "sub01_gpa": double.parse(Sub01GPACon.text),    // Use .text to get value
                "sub02": Sub02Con.value.toString(),
                "sub02_gpa": double.parse(Sub02GPACon.text),
                "sub03": Sub03Con.value.toString(),
                "sub03_gpa": double.parse(Sub03GPACon.text),
              };
              update_versity(versityData);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Successfully logged in", style: TextStyle(color: Colors.green),)
              ));
            }
            InstituteCon.clear();
            SubjectCon.clear();
            SeatCon.clear();
            CGPACon.clear();
            Sub03GPACon.clear();
            Sub02GPACon.clear();
            Sub01GPACon.clear();
            Sub03Con.setDefault();
            Sub02Con.setDefault();
            Sub01Con.setDefault();
          }),
          SizedBox(height: 30,),
          ]
        )
    );
  }
}
