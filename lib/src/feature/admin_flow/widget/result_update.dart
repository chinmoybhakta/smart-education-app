// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import '../../auth_screen/provider/student_provider.dart';
// import '../../common_widget/smart_button.dart';
// import '../../common_widget/smart_textfield.dart';
// import '../provider/toggle_provider.dart';
//
// final database = FirebaseDatabase.instance.ref();
// final student_ref = database.child("Student/");
// final result_ref = database.child("Result/");
// final admission_ref = database.child("Admission/");
//
// List<Widget> formbody = [
//   form_body01(),
//   form_body02()
// ];
//
// String? student_class;
// String? lead_sub_1;
// String? lead_sub_2;
// String? lead_sub_3;
// double lead_sub_1_gpa = 0.0;
// double lead_sub_2_gpa = 0.0;
// double lead_sub_3_gpa = 0.0;
// double gpa = 0.0;
//
// List<MapEntry<String, double>> sortByValue(Map<String, double> subGpa) {
//   var entries = subGpa.entries.toList();
//   entries.sort((a, b) => b.value.compareTo(a.value));
//   return entries;
// }
//
// double calculateGPA(double gpa1, double gpa2, double gpa3) {
//   double gpa = (gpa1 + gpa2 + gpa3) / 3;
//   if(gpa1 == 0.0 || gpa2 == 0.0 || gpa3 == 0.0) gpa = 0.0;
//   return (gpa * 100).roundToDouble()/100;
// }
//
// class result_update extends ConsumerStatefulWidget {
//   result_update({super.key});
//
//   @override
//   ConsumerState<result_update> createState() => _result_updateState();
// }
//
// class _result_updateState extends ConsumerState<result_update> {
//   int selectedScreen = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     readData(ref);
//   }
//
//   // @override
//   // dispose(){
//   //   banglaCon.dispose();
//   //   englishCon.dispose();
//   //   mathCon.dispose();
//   //   scienceCon.dispose();
//   //   artsCon.dispose();
//   //   careerCon.dispose();
//   //   computerCon.dispose();
//   //   ptCon.dispose();
//   //   litCon.dispose();
//   //   bsCon.dispose();
//   //   phyCon.dispose();
//   //   cheCon.dispose();
//   //   bioCon.dispose();
//   //   itCon.dispose();
//   //   accountCon.dispose();
//   //   financeCon.dispose();
//   //   marketCon.dispose();
//   //   fineCon.dispose();
//   //   musicCon.dispose();
//   //   archaeoCon.dispose();
//   //   psychoCon.dispose();
//   //   archiCon.dispose();
//   //   philoCon.dispose();
//   //   super.dispose();
//   // }
//
//   Future<void> readData(ref) async {
//     try {
//       int node = ref.read(studentNodeProvider.notifier).state;
//       DataSnapshot snapshot = await student_ref.child("$node").get();
//       if(snapshot.exists) {
//           ref.read(studentInfoProvider.notifier).state = Map<String, dynamic>.from(snapshot.value as Map);
//       }
//
//       student_class = ref.read(studentInfoProvider.notifier).state["Class"];
//
//       if(student_class == "one" ||
//       student_class == "two" ||
//       student_class == "three" ||
//       student_class == "four") {
//         setState(() {
//           selectedScreen = 0;
//         });
//       }
//
//       DataSnapshot snapshot2 = await result_ref.child("$node/").get();
//       if(snapshot2.exists) {
//           ref.read(studentResultProvider.notifier).state = Map<String, dynamic>.from(snapshot2.value as Map);
//       }
//     }catch(e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final student = ref.watch(studentInfoProvider);
//     String? studentName = student["Name"];
//     String? studentClass = student["Class"];
//     String? studentId = student["ID"];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("UPDATE RESULT"),
//         actions: [
//           Text("ID: $studentId\nName: $studentName\nClass: $studentClass"),
//         ],
//       ),
//       body: formbody[selectedScreen]
//     );
//   }
// }
//
// class form_body01 extends StatelessWidget {
//   const form_body01({super.key});
//
//   double parseDoubleOrZero(String? value) {
//     if (value == null || value.trim().isEmpty) return 0.0;
//     return double.tryParse(value) ?? 0.0;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 30.h,),
//           SmartTextfield(hintText: "Bangla GPA", controller: banglaCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "English GPA", controller: englishCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Math GPA", controller: mathCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Science GPA", controller: scienceCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Arts GPA", controller: artsCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Career GPA", controller: careerCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Computer GPA", controller: computerCon),
//           SizedBox(height: 30.h,),
//           Consumer(
//             builder: (_, ref, child) {
//               final student = ref.watch(studentInfoProvider);
//               final result = ref.watch(studentResultProvider);
//               return SmartButton(
//                 label: "Submit",
//                 onPressed: () async {
//                   preli_subjects["Bangla"] = parseDoubleOrZero(banglaCon.text);
//                   preli_subjects["English"] = parseDoubleOrZero(englishCon.text);
//                   preli_subjects["Math"] = parseDoubleOrZero(mathCon.text);
//                   preli_subjects["Science"] = parseDoubleOrZero(scienceCon.text);
//                   preli_subjects["Arts"] = parseDoubleOrZero(artsCon.text);
//                   preli_subjects["Career"] = parseDoubleOrZero(careerCon.text);
//                   preli_subjects["Physical Test"] = parseDoubleOrZero(ptCon.text);
//                   preli_subjects["Computer"] = parseDoubleOrZero(computerCon.text);
//
//                   var sorted_subjects = sortByValue(preli_subjects); //sorted subject is a list map
//                   lead_sub_1 = sorted_subjects[0].key;
//                   lead_sub_2 = sorted_subjects[1].key;
//                   lead_sub_3 = sorted_subjects[2].key;
//
//                   lead_sub_1_gpa = sorted_subjects[0].value;
//                   lead_sub_2_gpa = sorted_subjects[1].value;
//                   lead_sub_3_gpa = sorted_subjects[2].value;
//
//                   gpa = calculateGPA(lead_sub_1_gpa, lead_sub_2_gpa, lead_sub_3_gpa);
//
//                   int class_index = (class_details.indexOf(student['Class']) == 10) ? -1 : class_details.indexOf(student['Class']) + 1;
//
//                   preli_subjects.map((key, value) {
//                     return MapEntry(key, value.toString());
//                   });
//                   double CGPA = parseDoubleOrZero(result['CGPA']);
//                   try{
//
//                     debugPrint("student['ID'] type: ${student['ID'].runtimeType}");
//                     debugPrint("student['Class'] type: ${student['Class'].runtimeType}");
//
//                     await database.child("${student['Class']}/${student['ID']}/").update(preli_subjects);
//                     await database.child("${student['Class']}/${student['ID']}/").update({"GPA" : gpa});
//                     await result_ref.child("${student['ID']}/").update(
//                       {
//                         "1st_Lead_Subject" : lead_sub_1,
//                         "2nd_Lead_Subject" : lead_sub_2,
//                         "3rd_Lead_Subject" : lead_sub_3,
//                         "1st_Lead_Subject_GPA" : lead_sub_1_gpa,
//                         "2nd_Lead_Subject_GPA" : lead_sub_1_gpa,
//                         "3rd_Lead_Subject_GPA" : lead_sub_1_gpa,
//                         "CGPA" : CGPA,
//                         student['Class'] : gpa
//                       }
//                     );
//                     if(gpa != 0.0) await student_ref.child("${student['ID']}/").update({"Class" : class_details[class_index]});
//                     context.pop();
//                   }catch(e, st){
//                     debugPrint("\n\n\n\n$e\n\n\n");
//                     debugPrint("\n\n\n\n$st\n\n\n\n");
//                     if(!context.mounted) return;
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Failed to update Student result", style: TextStyle(color: Colors.red),)
//                   ));
//                   }
//
//                 },
//               );
//             }
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class form_body02 extends StatelessWidget {
//   const form_body02({super.key});
//
//   double parseDoubleOrZero(String? value) {
//     if (value == null || value.trim().isEmpty) return 0.0;
//     return double.tryParse(value) ?? 0.0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 30.h,),
//           SmartTextfield(hintText: "Literature GPA", controller: litCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "English GPA", controller: englishCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Math GPA", controller: mathCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Physical Test GPA", controller: ptCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Bangladesh Studies GPA", controller: bsCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "IT GPA", controller: itCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Physics GPA", controller: phyCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Chemistry GPA", controller: cheCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Biology GPA", controller: bioCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Accounting GPA", controller: accountCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Finance & Management GPA", controller: financeCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Marketing GPA", controller: marketCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Fine Arts GPA", controller: fineCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Music GPA", controller: musicCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Archaeology GPA", controller: archaeoCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Psychology GPA", controller: psychoCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Philosophy GPA", controller: philoCon),
//           SizedBox(height: 10.h,),
//           SmartTextfield(hintText: "Architecture GPA", controller: archiCon),
//           SizedBox(height: 30.h,),
//           Consumer(
//             builder: (_, ref, child) {
//               final node = ref.watch(studentNodeProvider);
//               final student = ref.watch(studentInfoProvider);
//               debugPrint("\n\n\n${student["Class"]}\n\n\n");
//               final result = ref.watch(studentResultProvider);
//               debugPrint("\n\n\n${result["CGPA"]}\n\n\n");
//               return SmartButton(
//                 label: "Submit",
//                 onPressed: () async {
//                   try{
//                   advance_subjects["Literature"] = parseDoubleOrZero(litCon.text);
//                   advance_subjects["English"] = parseDoubleOrZero(englishCon.text);
//                   advance_subjects["Math"] = parseDoubleOrZero(mathCon.text);
//                   advance_subjects["Physical Test"] = parseDoubleOrZero(ptCon.text);
//                   advance_subjects["Bangladesh Studies"] = parseDoubleOrZero(bsCon.text);
//                   advance_subjects["IT"] = parseDoubleOrZero(itCon.text);
//                   advance_subjects["Physics"] = parseDoubleOrZero(phyCon.text);
//                   advance_subjects["Chemistry"] = parseDoubleOrZero(cheCon.text);
//                   advance_subjects["Biology"] = parseDoubleOrZero(bioCon.text);
//                   advance_subjects["Accounting"] = parseDoubleOrZero(accountCon.text);
//                   advance_subjects["Finance & Management"] = parseDoubleOrZero(financeCon.text);
//                   advance_subjects["Marketing"] = parseDoubleOrZero(marketCon.text);
//                   advance_subjects["Fine Arts"] = parseDoubleOrZero(fineCon.text);
//                   advance_subjects["Music"] = parseDoubleOrZero(musicCon.text);
//                   advance_subjects["Archaeology"] = parseDoubleOrZero(archaeoCon.text);
//                   advance_subjects["Philosophy"] = parseDoubleOrZero(philoCon.text);
//                   advance_subjects["Psychology"] = parseDoubleOrZero(psychoCon.text);
//                   advance_subjects["Architecture"] = parseDoubleOrZero(archiCon.text);
//
//                   var sorted_subjects = sortByValue(advance_subjects); //sorted subject is a list map
//                   lead_sub_1 = sorted_subjects[0].key;
//                   lead_sub_2 = sorted_subjects[1].key;
//                   lead_sub_3 = sorted_subjects[2].key;
//
//                   lead_sub_1_gpa = sorted_subjects[0].value;
//                   lead_sub_2_gpa = sorted_subjects[1].value;
//                   lead_sub_3_gpa = sorted_subjects[2].value;
//
//                   gpa = calculateGPA(lead_sub_1_gpa, lead_sub_2_gpa, lead_sub_3_gpa);
//
//                   int class_index = (class_details.indexOf(student['Class']) == 11) ? -1 : class_details.indexOf(student['Class']) + 1;
//
//                   advance_subjects.map((key, value) {
//                     return MapEntry(key, value.toString());
//                   });
//
//                   double CGPA = result['CGPA'].toDouble();
//
//                     //UPDATE
//                     await database.child("${student['Class']}/$node/").update(advance_subjects);
//                     await database.child("${student['Class']}/$node/").update({"GPA" : gpa});
//                     await result_ref.child("$node/").update(
//                         {
//                           "1st_Lead_Subject" : lead_sub_1,
//                           "2nd_Lead_Subject" : lead_sub_2,
//                           "3rd_Lead_Subject" : lead_sub_3,
//                           "1st_Lead_Subject_GPA" : lead_sub_1_gpa,
//                           "2nd_Lead_Subject_GPA" : lead_sub_1_gpa,
//                           "3rd_Lead_Subject_GPA" : lead_sub_1_gpa,
//                           "CGPA" : CGPA,
//                           student['Class'] : gpa
//                         }
//                     );
//                     if(gpa != 0 && class_index != -1) await student_ref.child("$node/").update({"Class" : class_details[class_index]});
//                     litCon.clear();
//                     englishCon.clear();
//                     mathCon.clear();
//                     bsCon.clear();
//                     ptCon.clear();
//                     phyCon.clear();
//                     cheCon.clear();
//                     bioCon.clear();
//                     itCon.clear();
//                     archiCon.clear();
//                     fineCon.clear();
//                     musicCon.clear();
//                     archaeoCon.clear();
//                     philoCon.clear();
//                     psychoCon.clear();
//                     accountCon.clear();
//                     financeCon.clear();
//                     marketCon.clear();
//                     context.pop();
//                   }catch(e, stackTrace){
//                     debugPrint('Error occurred: $e');
//                     debugPrint('Stack trace:\n$stackTrace');
//                     rethrow;
//                     if(!context.mounted) return;
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Failed to update Student result", style: TextStyle(color: Colors.red),)
//                   ));}
//                 },
//               );
//             }
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
