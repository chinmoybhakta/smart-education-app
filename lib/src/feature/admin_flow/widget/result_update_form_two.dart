import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/service/firebase_service/checkID&Pass.dart';
import '../../../core/utils/utils.dart';
import '../../auth_screen/provider/student_provider.dart';
import '../../common_widget/smart_button.dart';
import '../../common_widget/smart_textfield.dart';
import '../provider/toggle_provider.dart';

class ResultUpdateFormTwo extends ConsumerStatefulWidget {
  const ResultUpdateFormTwo({super.key});

  @override
  ConsumerState<ResultUpdateFormTwo> createState() =>
      _ResultUpdateFormTwoState();
}

class _ResultUpdateFormTwoState extends ConsumerState<ResultUpdateFormTwo> {
  final resultRef = database.child("Result/");

  late TextEditingController litCon;
  late TextEditingController englishCon;
  late TextEditingController mathCon;
  late TextEditingController bsCon;
  late TextEditingController ptCon;
  late TextEditingController phyCon;
  late TextEditingController cheCon;
  late TextEditingController bioCon;
  late TextEditingController itCon;
  late TextEditingController accountCon;
  late TextEditingController financeCon;
  late TextEditingController marketCon;
  late TextEditingController fineCon;
  late TextEditingController musicCon;
  late TextEditingController archaeoCon;
  late TextEditingController psychoCon;
  late TextEditingController archiCon;
  late TextEditingController philoCon;

  @override
  void initState() {
    litCon = TextEditingController();
    bsCon = TextEditingController();
    phyCon = TextEditingController();
    cheCon = TextEditingController();
    bioCon = TextEditingController();
    itCon = TextEditingController();
    accountCon = TextEditingController();
    financeCon = TextEditingController();
    marketCon = TextEditingController();
    fineCon = TextEditingController();
    musicCon = TextEditingController();
    archaeoCon = TextEditingController();
    psychoCon = TextEditingController();
    archiCon = TextEditingController();
    philoCon = TextEditingController();
    englishCon = TextEditingController();
    mathCon = TextEditingController();
    ptCon = TextEditingController();

    readData();
    super.initState();
  }

  @override
  void dispose() {
    litCon.dispose();
    bsCon.dispose();
    phyCon.dispose();
    cheCon.dispose();
    bioCon.dispose();
    itCon.dispose();
    accountCon.dispose();
    financeCon.dispose();
    marketCon.dispose();
    fineCon.dispose();
    musicCon.dispose();
    archaeoCon.dispose();
    psychoCon.dispose();
    archiCon.dispose();
    philoCon.dispose();

    super.dispose();
  }

  Future<void> readData() async {
    try {
      int node = ref.read(studentNodeProvider.notifier).state;
      DataSnapshot snapshot2 = await resultRef.child("$node/").get();
      if (snapshot2.exists) {
        ref
            .read(studentResultProvider.notifier)
            .state = Map<String, dynamic>.from(snapshot2.value as Map);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  double parseDoubleOrZero(String? value) {
    if (value == null || value.trim().isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  double calculateGPA(double gpa1, double gpa2, double gpa3) {
    double gpa = (gpa1 + gpa2 + gpa3) / 3;
    if (gpa1 == 0.0 || gpa2 == 0.0 || gpa3 == 0.0) gpa = 0.0;
    return (gpa * 100).roundToDouble() / 100;
  }

  List<MapEntry<String, double>> sortByValue(Map<String, double> subGpa) {
    var entries = subGpa.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  final Map<String, double> advanceSubjects = {
    "Literature": 0.0,
    "English": 0.0,
    "Math": 0.0,
    "Physical Test": 0.0,
    "Bangladesh Studies": 0.0,
    "IT": 0.0,
    "Physics": 0.0,
    "Chemistry": 0.0,
    "Biology": 0.0,
    "Accounting": 0.0,
    "Finance & Management": 0.0,
    "Marketing": 0.0,
    "Fine Arts": 0.0,
    "Music": 0.0,
    "Archaeology": 0.0,
    "Philosophy": 0.0,
    "Psychology": 0.0,
    "Architecture": 0.0,
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
            SizedBox(height: 30.h),
            SmartTextfield(hintText: "Literature GPA", controller: litCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "English GPA", controller: englishCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Math GPA", controller: mathCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
            SizedBox(height: 10.h),
            SmartTextfield(
              hintText: "Bangladesh Studies GPA",
              controller: bsCon,
            ),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "IT GPA", controller: itCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Physics GPA", controller: phyCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Chemistry GPA", controller: cheCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Biology GPA", controller: bioCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Accounting GPA", controller: accountCon),
            SizedBox(height: 10.h),
            SmartTextfield(
              hintText: "Finance & Management GPA",
              controller: financeCon,
            ),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Marketing GPA", controller: marketCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Fine Arts GPA", controller: fineCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Music GPA", controller: musicCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Archaeology GPA", controller: archaeoCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Psychology GPA", controller: psychoCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Philosophy GPA", controller: philoCon),
            SizedBox(height: 10.h),
            SmartTextfield(hintText: "Architecture GPA", controller: archiCon),
            SizedBox(height: 30.h),
            Consumer(
              builder: (_, ref, child) {
                return SmartButton(
                  label: "Submit",
                  onPressed: () async {
                    try {
                      advanceSubjects["Literature"] = parseDoubleOrZero(
                        litCon.text,
                      );
                      advanceSubjects["English"] = parseDoubleOrZero(
                        englishCon.text,
                      );
                      advanceSubjects["Math"] = parseDoubleOrZero(mathCon.text);
                      advanceSubjects["Physical Test"] = parseDoubleOrZero(
                        ptCon.text,
                      );
                      advanceSubjects["Bangladesh Studies"] = parseDoubleOrZero(
                        bsCon.text,
                      );
                      advanceSubjects["IT"] = parseDoubleOrZero(itCon.text);
                      advanceSubjects["Physics"] = parseDoubleOrZero(
                        phyCon.text,
                      );
                      advanceSubjects["Chemistry"] = parseDoubleOrZero(
                        cheCon.text,
                      );
                      advanceSubjects["Biology"] = parseDoubleOrZero(
                        bioCon.text,
                      );
                      advanceSubjects["Accounting"] = parseDoubleOrZero(
                        accountCon.text,
                      );
                      advanceSubjects["Finance & Management"] = parseDoubleOrZero(
                          financeCon.text
                      );
                      advanceSubjects["Marketing"] = parseDoubleOrZero(
                        marketCon.text,
                      );
                      advanceSubjects["Fine Arts"] = parseDoubleOrZero(
                        fineCon.text,
                      );
                      advanceSubjects["Music"] = parseDoubleOrZero(
                        musicCon.text,
                      );
                      advanceSubjects["Archaeology"] = parseDoubleOrZero(
                        archaeoCon.text,
                      );
                      advanceSubjects["Philosophy"] = parseDoubleOrZero(
                        philoCon.text,
                      );
                      advanceSubjects["Psychology"] = parseDoubleOrZero(
                        psychoCon.text,
                      );
                      advanceSubjects["Architecture"] = parseDoubleOrZero(
                        archiCon.text,
                      );

                      var sortedSubjects = sortByValue(
                        advanceSubjects,
                      ); //sorted subject is a list map
                      final String leadSub1 = sortedSubjects[0].key;
                      final String leadSub2 = sortedSubjects[1].key;
                      final String leadSub3 = sortedSubjects[2].key;

                      leadSubGpa1 = sortedSubjects[0].value;
                      leadSubGpa2 = sortedSubjects[1].value;
                      leadSubGpa3 = sortedSubjects[2].value;

                      gpa = calculateGPA(leadSubGpa1, leadSubGpa2, leadSubGpa3);

                      debugPrint("\n\n\n\n$leadSub1\n\n\n\n");
                      debugPrint("\n\n\n\n$leadSub2\n\n\n\n");
                      debugPrint("\n\n\n\n$leadSub3\n\n\n\n");
                      debugPrint("\n\n\n\n$leadSubGpa1\n\n\n\n");
                      debugPrint("\n\n\n\n$leadSubGpa2\n\n\n\n");
                      debugPrint("\n\n\n\n$leadSubGpa3\n\n\n\n");
                      debugPrint("\n\n\n\n$gpa\n\n\n\n");

                      int classIndex =
                          (util.classDetails.indexOf(student['Class']) == 11)
                              ? -1
                              : util.classDetails.indexOf(student['Class']) + 1;

                      advanceSubjects.map((key, value) {
                        return MapEntry(key, value.toString());
                      });
                      double CGPA = ref.read(calculateCGPAProvider);

                      debugPrint("\n\n\n\n$CGPA\n\n\n\n");

                      //UPDATE
                      await database
                          .child("${student['Class']}/$node/")
                          .update(advanceSubjects);
                      await database.child("${student['Class']}/$node/").update(
                        {"GPA": gpa},
                      );
                      await resultRef.child("$node/").update({
                        "1st_Lead_Subject": leadSub1,
                        "2nd_Lead_Subject": leadSub2,
                        "3rd_Lead_Subject": leadSub3,
                        "1st_Lead_Subject_GPA": leadSubGpa1,
                        "2nd_Lead_Subject_GPA": leadSubGpa2,
                        "3rd_Lead_Subject_GPA": leadSubGpa3,
                        "CGPA": CGPA,
                        student['Class']: gpa,
                      });
                      if (gpa >= 2.75 && classIndex != -1) {
                        await studentRef.child("$node/").update({
                          "Class": util.classDetails[classIndex],
                        });
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${student["Name"]} has passed class ${student["Class"]}",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        );
                        context.pop();
                      } else {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Sorry! ${student["Name"]} failed in class ${student["Class"]}",
                              style: const TextStyle(color: Colors.yellow),
                            ),
                          ),
                        );
                      }
                    } catch (e, stackTrace) {
                      debugPrint('student[\'Class\']: ${student['Class']}');
                      debugPrint('Error occurred: $e');
                      debugPrint('Stack trace:\n$stackTrace');
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Failed to update Student result",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}
