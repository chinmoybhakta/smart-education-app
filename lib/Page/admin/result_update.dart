import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Widget/smart_button.dart';
import 'package:smart_education_app/Widget/smart_textfield.dart';
import 'package:smart_education_app/feature/getter_setter.dart';

TextEditingController banglaCon = TextEditingController();
TextEditingController scienceCon = TextEditingController();
TextEditingController artsCon = TextEditingController();
TextEditingController careerCon = TextEditingController();
TextEditingController computerCon = TextEditingController();
TextEditingController ptCon = TextEditingController();
TextEditingController englishCon = TextEditingController();
TextEditingController mathCon = TextEditingController();

TextEditingController litCon = TextEditingController();
TextEditingController bsCon = TextEditingController();
TextEditingController phyCon = TextEditingController();
TextEditingController cheCon = TextEditingController();
TextEditingController bioCon = TextEditingController();
TextEditingController itCon = TextEditingController();
TextEditingController accountCon = TextEditingController();
TextEditingController financeCon = TextEditingController();
TextEditingController marketCon = TextEditingController();
TextEditingController fineCon = TextEditingController();
TextEditingController musicCon = TextEditingController();
TextEditingController archaeoCon = TextEditingController();
TextEditingController psychoCon = TextEditingController();
TextEditingController archiCon = TextEditingController();
TextEditingController philoCon = TextEditingController();

final database = FirebaseDatabase.instance.ref();
final student_ref = database.child("Student/");
final result_ref = database.child("Result/");
final admission_ref = database.child("Admission/");

List<Widget> formbody = [
  form_body01(),
  form_body02()
];

List<String> class_details = [
  "one", "two", 'three', "four", "five", "six", "seven", "eight", "nine", "ten", "admission"
];

Map<String, double> preli_subjects = {
  "Bangla" : 0.0,
  "English" : 0.0,
  "Math" : 0.0,
  "Physical Test" : 0.0,
  "Science" : 0.0,
  "Arts" : 0.0,
  "Career" : 0.0,
  "Computer" : 0.0
};

Map<String, double> advance_subjects = {
  "Literature" : 0.0,
  "English" : 0.0,
  "Math" : 0.0,
  "Physical Test" : 0.0,
  "Bangladesh Studies" : 0.0,
  "IT" : 0.0,
  "Physics" : 0.0,
  "Chemistry" : 0.0,
  "Biology" : 0.0,
  "Accounting" : 0.0,
  "Finance & Management" : 0.0,
  "Marketing" : 0.0,
  "Fine Arts" : 0.0,
  "Music" : 0.0,
  "Archaeology" : 0.0,
  "Philosophy" : 0.0,
  "Psychology" : 0.0,
  "Architecture" : 0.0,
};

String? student_class;
String? lead_sub_1;
String? lead_sub_2;
String? lead_sub_3;
double lead_sub_1_gpa = 0.0;
double lead_sub_2_gpa = 0.0;
double lead_sub_3_gpa = 0.0;
double gpa = 0.0;

List<MapEntry<String, double>> sortByValue(Map<String, double> subGpa) {
  var entries = subGpa.entries.toList();
  entries.sort((a, b) => b.value.compareTo(a.value));
  return entries;
}

double calculateGPA(double gpa1, double gpa2, double gpa3) {
  double gpa = (gpa1 + gpa2 + gpa3) / 3;
  if(gpa1 == 0.0 || gpa2 == 0.0 || gpa3 == 0.0) gpa = 0.0;
  return (gpa * 100).roundToDouble()/100;
}

class result_update extends StatefulWidget {
  result_update({super.key});

  @override
  State<result_update> createState() => _result_updateState();
}

class _result_updateState extends State<result_update> {
  StudentIdentity SI = StudentIdentity();
  Map<String, dynamic>? student;
  Map<String, dynamic>? resultData;
  int selectedScreen = 1;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    try {
      int node = SI.getIdentity();
      DataSnapshot snapshot = await student_ref.child("$node").get();
      if(snapshot.exists) {
        setState(() {
          student = Map<String, dynamic>.from(snapshot.value as Map);
          SI.setClass(student?["Class"]);
        });
      }

      student_class = SI.getClass();

      if(student_class == "one" ||
      student_class == "two" ||
      student_class == "three" ||
      student_class == "four") {
        setState(() {
          selectedScreen = 0;
        });
      }
      
      DataSnapshot snapshot2 = await result_ref.child("$node/").get();
      if(snapshot2.exists) {
        setState(() {
          resultData = Map<String, dynamic>.from(snapshot2.value as Map);
          SI.setResultData(resultData!);
        });
      }

    }catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? student_name = student?["Name"];
    String? student_class = student?["Class"];
    String? student_id = student?["ID"];

    return Scaffold(
      appBar: AppBar(
        title: Text("UPDATE RESULT"),
        actions: [
          Text("ID: $student_id\nName: $student_name\nClass: $student_class"),
        ],
      ),
      body: formbody[selectedScreen]
    );
  }
}

class form_body01 extends StatelessWidget {
  const form_body01({super.key});

  @override
  Widget build(BuildContext context) {
    StudentIdentity SI = StudentIdentity();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          SmartTextfield(hintText: "Bangla GPA", controller: banglaCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "English GPA", controller: englishCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Math GPA", controller: mathCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Science GPA", controller: scienceCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Arts GPA", controller: artsCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Career GPA", controller: careerCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Computer GPA", controller: computerCon),
          SizedBox(height: 30,),
          SmartButton(
            label: "Submit",
            onPressed: () async {
              preli_subjects["Bangla"] = double.parse(banglaCon.text);
              preli_subjects["English"] = double.parse(englishCon.text);
              preli_subjects["Math"] = double.parse(mathCon.text);
              preli_subjects["Science"] = double.parse(scienceCon.text);
              preli_subjects["Arts"] = double.parse(artsCon.text);
              preli_subjects["Career"] = double.parse(careerCon.text);
              preli_subjects["Physical Test"] = double.parse(ptCon.text);
              preli_subjects["Computer"] = double.parse(computerCon.text);

              var sorted_subjects = sortByValue(preli_subjects); //sorted subject is a list map
              lead_sub_1 = sorted_subjects[0].key;
              lead_sub_2 = sorted_subjects[1].key;
              lead_sub_3 = sorted_subjects[2].key;

              lead_sub_1_gpa = sorted_subjects[0].value;
              lead_sub_2_gpa = sorted_subjects[1].value;
              lead_sub_3_gpa = sorted_subjects[2].value;

              gpa = calculateGPA(lead_sub_1_gpa, lead_sub_2_gpa, lead_sub_3_gpa);

              int class_index = (class_details.indexOf(SI.getClass()) == 10) ? -1 : class_details.indexOf(SI.getClass()) + 1;

              preli_subjects.map((key, value) {
                return MapEntry(key, value.toString());
              });
              double CGPA = SI.getCGPA();
              try{
                await database.child("${SI.getClass()}/${SI.getIdentity()}/").update(preli_subjects);
                await database.child("${SI.getClass()}/${SI.getIdentity()}/").update({"GPA" : gpa});
                await result_ref.child("${SI.getIdentity()}/").update(
                  {
                    "1st_Lead_Subject" : lead_sub_1,
                    "2nd_Lead_Subject" : lead_sub_2,
                    "3rd_Lead_Subject" : lead_sub_3,
                    "1st_Lead_Subject_GPA" : lead_sub_1_gpa,
                    "2nd_Lead_Subject_GPA" : lead_sub_1_gpa,
                    "3rd_Lead_Subject_GPA" : lead_sub_1_gpa,
                    "CGPA" : CGPA,
                    SI.getClass() : gpa
                  }
                );
                if(gpa != 0) await student_ref.child("${SI.getIdentity()}/").update({"Class" : class_details[class_index]});
                banglaCon.clear();
                englishCon.clear();
                mathCon.clear();
                scienceCon.clear();
                artsCon.clear();
                computerCon.clear();
                careerCon.clear();
                ptCon.clear();
                Navigator.pop(context, true);
              }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to update Student result", style: TextStyle(color: Colors.red),)
              ));}

            },
          )
        ],
      ),
    );
  }
}

class form_body02 extends StatelessWidget {
  const form_body02({super.key});

  @override
  Widget build(BuildContext context) {

    StudentIdentity SI = StudentIdentity();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          SmartTextfield(hintText: "Literature GPA", controller: litCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "English GPA", controller: englishCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Math GPA", controller: mathCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Bangladesh Studies GPA", controller: bsCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "IT GPA", controller: itCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Physics GPA", controller: phyCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Chemistry GPA", controller: cheCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Biology GPA", controller: bioCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Accounting GPA", controller: accountCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Finance & Management GPA", controller: financeCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Marketing GPA", controller: marketCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Fine Arts GPA", controller: fineCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Music GPA", controller: musicCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Archaeology GPA", controller: archaeoCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Psychology GPA", controller: psychoCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Philosophy GPA", controller: philoCon),
          SizedBox(height: 10,),
          SmartTextfield(hintText: "Architecture GPA", controller: archiCon),
          SizedBox(height: 30,),
          SmartButton(
            label: "Submit",
            onPressed: () async {
              try{
              advance_subjects["Literature"] = double.parse(litCon.text);
              advance_subjects["English"] = double.parse(englishCon.text);
              advance_subjects["Math"] = double.parse(mathCon.text);
              advance_subjects["Physical Test"] = double.parse(ptCon.text);
              advance_subjects["Bangladesh Studies"] = double.parse(bsCon.text);
              advance_subjects["IT"] = double.parse(itCon.text);
              advance_subjects["Physics"] = double.parse(phyCon.text);
              advance_subjects["Chemistry"] = double.parse(cheCon.text);
              advance_subjects["Biology"] = double.parse(bioCon.text);
              advance_subjects["Accounting"] = double.parse(accountCon.text);
              advance_subjects["Finance & Management"] = double.parse(financeCon.text);
              advance_subjects["Marketing"] = double.parse(marketCon.text);
              advance_subjects["Fine Arts"] = double.parse(fineCon.text);
              advance_subjects["Music"] = double.parse(musicCon.text);
              advance_subjects["Archaeology"] = double.parse(archaeoCon.text);
              advance_subjects["Philosophy"] = double.parse(philoCon.text);
              advance_subjects["Psychology"] = double.parse(psychoCon.text);
              advance_subjects["Architecture"] = double.parse(archiCon.text);

              var sorted_subjects = sortByValue(advance_subjects); //sorted subject is a list map
              lead_sub_1 = sorted_subjects[0].key;
              lead_sub_2 = sorted_subjects[1].key;
              lead_sub_3 = sorted_subjects[2].key;

              lead_sub_1_gpa = sorted_subjects[0].value;
              lead_sub_2_gpa = sorted_subjects[1].value;
              lead_sub_3_gpa = sorted_subjects[2].value;

              gpa = calculateGPA(lead_sub_1_gpa, lead_sub_2_gpa, lead_sub_3_gpa);

              int class_index = (class_details.indexOf(SI.getClass()) == 11) ? -1 : class_details.indexOf(SI.getClass()) + 1;

              advance_subjects.map((key, value) {
                return MapEntry(key, value.toString());
              });

              double CGPA = SI.getCGPA();


                await database.child("${SI.getClass()}/${SI.getIdentity()}/").update(advance_subjects);
                await database.child("${SI.getClass()}/${SI.getIdentity()}/").update({"GPA" : gpa});
                await result_ref.child("${SI.getIdentity()}/").update(
                    {
                      "1st_Lead_Subject" : lead_sub_1,
                      "2nd_Lead_Subject" : lead_sub_2,
                      "3rd_Lead_Subject" : lead_sub_3,
                      "1st_Lead_Subject_GPA" : lead_sub_1_gpa,
                      "2nd_Lead_Subject_GPA" : lead_sub_1_gpa,
                      "3rd_Lead_Subject_GPA" : lead_sub_1_gpa,
                      "CGPA" : CGPA,
                      SI.getClass() : gpa
                    }
                );
                if(gpa != 0 && class_index != -1) await student_ref.child("${SI.getIdentity()}/").update({"Class" : class_details[class_index]});
                litCon.clear();
                englishCon.clear();
                mathCon.clear();
                bsCon.clear();
                ptCon.clear();
                phyCon.clear();
                cheCon.clear();
                bioCon.clear();
                itCon.clear();
                archiCon.clear();
                fineCon.clear();
                musicCon.clear();
                archaeoCon.clear();
                philoCon.clear();
                psychoCon.clear();
                accountCon.clear();
                financeCon.clear();
                marketCon.clear();
                Navigator.pop(context, true);
              }catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to update Student result", style: TextStyle(color: Colors.red),)
              ));}
            },
          )
        ],
      ),
    );
  }
}






