import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/feature/admin_flow/provider/toggle_provider.dart';
import '../../../core/service/firebase_service/checkID&Pass.dart';
import '../../../core/utils/utils.dart';
import '../../auth_screen/provider/student_provider.dart';
import '../../common_widget/smart_button.dart';
import '../../common_widget/smart_textfield.dart';

class ResultUpdateFormOne extends ConsumerStatefulWidget {
  const ResultUpdateFormOne({super.key});

  @override
  ConsumerState<ResultUpdateFormOne> createState() => _ResultUpdateFormOneState();
}

class _ResultUpdateFormOneState extends ConsumerState<ResultUpdateFormOne> {

  final resultRef = database.child("Result/");

  late TextEditingController banglaCon;
  late TextEditingController scienceCon;
  late TextEditingController artsCon;
  late TextEditingController careerCon;
  late TextEditingController computerCon;
  late TextEditingController ptCon;
  late TextEditingController englishCon;
  late TextEditingController mathCon;

  @override
  void initState() {
    banglaCon = TextEditingController();
    scienceCon = TextEditingController();
    artsCon = TextEditingController();
    careerCon = TextEditingController();
    computerCon = TextEditingController();
    ptCon = TextEditingController();
    englishCon = TextEditingController();
    mathCon = TextEditingController();

    readData();
    super.initState();
  }

  @override
  void dispose() {
    banglaCon.dispose();
    scienceCon.dispose();
    artsCon.dispose();
    careerCon.dispose();
    computerCon.dispose();
    ptCon.dispose();
    englishCon.dispose();
    mathCon.dispose();

    super.dispose();
  }

    Future<void> readData() async {
    try {
      int node = ref.read(studentNodeProvider.notifier).state;
      DataSnapshot snapshot2 = await resultRef.child("$node/").get();
      if(snapshot2.exists) {
          ref.read(studentResultProvider.notifier).state = Map<String, dynamic>.from(snapshot2.value as Map);
      }
    }catch(e) {
      debugPrint(e.toString());
    }
  }

  double parseDoubleOrZero(String? value) {
    if (value == null || value.trim().isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  double calculateGPA(double gpa1, double gpa2, double gpa3) {
    double gpa = (gpa1 + gpa2 + gpa3) / 3;
    if(gpa1 == 0.0 || gpa2 == 0.0 || gpa3 == 0.0) gpa = 0.0;
    return (gpa * 100).roundToDouble()/100;
  }

  List<MapEntry<String, double>> sortByValue(Map<String, double> subGpa) {
    var entries = subGpa.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  final Map<String, double> preliSubjects = {
    "Bangla" : 0.0,
    "English" : 0.0,
    "Math" : 0.0,
    "Physical Test" : 0.0,
    "Science" : 0.0,
    "Arts" : 0.0,
    "Career" : 0.0,
    "Computer" : 0.0,
  };

  @override
  Widget build(BuildContext context) {
    final node = ref.watch(studentNodeProvider);
    final student = ref.watch(studentInfoProvider);
    final studentId = student["ID"];
    final studentName = student["Name"];
    final studentClass = student["Class"];
    final util = Utils();
    late double leadSubGpa1, leadSubGpa2, leadSubGpa3, gpa;
    return Scaffold(
        appBar: AppBar(
        title: const Text("UPDATE RESULT"),
        actions: [
          Text("ID: $studentId\nName: $studentName\nClass: $studentClass"),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            SmartTextfield(hintText: "Bangla GPA", controller: banglaCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "English GPA", controller: englishCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Math GPA", controller: mathCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Science GPA", controller: scienceCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Arts GPA", controller: artsCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Career GPA", controller: careerCon),
            SizedBox(height: 10.h,),
            SmartTextfield(hintText: "Computer GPA", controller: computerCon),
            SizedBox(height: 30.h,),
            Consumer(
                builder: (_, ref, child) {
                  return SmartButton(
                    label: "Submit",
                    onPressed: () async {
                      preliSubjects["Bangla"] = parseDoubleOrZero(banglaCon.text);
                      preliSubjects["English"] = parseDoubleOrZero(englishCon.text);
                      preliSubjects["Math"] = parseDoubleOrZero(mathCon.text);
                      preliSubjects["Science"] = parseDoubleOrZero(scienceCon.text);
                      preliSubjects["Arts"] = parseDoubleOrZero(artsCon.text);
                      preliSubjects["Career"] = parseDoubleOrZero(careerCon.text);
                      preliSubjects["Physical Test"] = parseDoubleOrZero(ptCon.text);
                      preliSubjects["Computer"] = parseDoubleOrZero(computerCon.text);

                      var sortedSubjects = sortByValue(preliSubjects); //sorted subject is a list map

                      final leadSub1 = sortedSubjects[0].key;
                      final leadSub2 = sortedSubjects[1].key;
                      final leadSub3 = sortedSubjects[2].key;

                      leadSubGpa1 = sortedSubjects[0].value;
                      leadSubGpa2 = sortedSubjects[1].value;
                      leadSubGpa3 = sortedSubjects[2].value;

                      gpa = calculateGPA(leadSubGpa1, leadSubGpa2, leadSubGpa3);

                      int classIndex = (util.classDetails.indexOf(student['Class']) == 10) ? -1 : util.classDetails.indexOf(student['Class']) + 1;

                      preliSubjects.map((key, value) {
                        return MapEntry(key, value.toString());
                      });
                      double CGPA = ref.read(calculateCGPAProvider);

                      debugPrint(CGPA.toString());
                      try{

                        await database.child("${student['Class']}/$node/").update(preliSubjects);
                        await database.child("${student['Class']}/$node/").update({"GPA" : gpa});
                        await resultRef.child("$node/").update(
                            {
                              "1st_Lead_Subject" : leadSub1,
                              "2nd_Lead_Subject" : leadSub2,
                              "3rd_Lead_Subject" : leadSub3,
                              "1st_Lead_Subject_GPA" : leadSubGpa1,
                              "2nd_Lead_Subject_GPA" : leadSubGpa2,
                              "3rd_Lead_Subject_GPA" : leadSubGpa3,
                              "CGPA" : CGPA,
                              student['Class'] : gpa
                            }
                        );
                        if(gpa >= 2.75) {
                          await studentRef.child("$node/").update({"Class" : util.classDetails[classIndex]});
                          if(!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${student["Name"]} has passed class ${student["Class"]}", style: const TextStyle(color: Colors.green),)
                          ));
                          context.pop();
                        } else{
                          if(!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Sorry! ${student["Name"]} failed in class ${student["Class"]}", style: const TextStyle(color: Colors.yellow),)
                          ));
                        }
                      }catch(e, st){
                        debugPrint("\n\n\n\n$e\n\n\n");
                        debugPrint("\n\n\n\n$st\n\n\n\n");
                        if(!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Failed to update Student result", style: TextStyle(color: Colors.red),)
                        ));
                      }

                    },
                  );
                }
            )
          ],
        ),
      ),
    );;
  }
}
