import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service/firebase_service/checkID&Pass.dart';
import '../../admin_flow/provider/toggle_provider.dart';
import '../../auth_screen/provider/student_provider.dart';
import '../../common_widget/smart_button.dart';
import '../../common_widget/smart_dropdowns.dart';
import '../../common_widget/smart_inforow.dart';
import '../provider/result_provider.dart';

class user_result extends ConsumerWidget {
  const user_result({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ResultData = ref.watch(studentResultProvider);
    final OneData = ref.watch(classResultProvider(1));
    final TwoData = ref.watch(classResultProvider(2));
    final ThreeData = ref.watch(classResultProvider(3));
    final FourData = ref.watch(classResultProvider(4));
    final FiveData = ref.watch(classResultProvider(5));
    final SixData = ref.watch(classResultProvider(6));
    final SevenData = ref.watch(classResultProvider(7));
    final EightData = ref.watch(classResultProvider(8));
    final NineData = ref.watch(classResultProvider(9));
    final TenData = ref.watch(classResultProvider(10));
    SmartDropdownController ClassControl = SmartDropdownController();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 30.h,),
          Text("Overall Result Review", style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-01 GPA: ", value: "${ResultData["one"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-02 GPA: ", value: "${ResultData["two"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-03 GPA: ", value: "${ResultData["three"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-04 GPA: ", value: "${ResultData["four"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-05 GPA: ", value: "${ResultData["five"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-06 GPA: ", value: "${ResultData["six"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-07 GPA: ", value: "${ResultData["seven"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-08 GPA: ", value: "${ResultData["eight"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-09 GPA: ", value: "${ResultData["nine"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "Class-10 GPA: ", value: "${ResultData["ten"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 10.h,),
          SmartInfoRow(label: "CGPA: ", value: "${ResultData["CGPA"].toStringAsFixed(2)} out of 4.00"),
          SizedBox(height: 30.h,),
          SmartDropdown(labelText: "Result Detail of Class", items: const [
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please Select Class!", style: TextStyle(color: Colors.red),)
              ));
            }
          },)
        ],
      ),
    );
  }
}

void PreliClassResultPop(BuildContext context, Map<String, dynamic> data, String ClassDetails) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ClassDetails,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text("Physical Test: ${data["Physical Test"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Bangla: ${data["Bangla"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("English: ${data["English"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Math: ${data["Math"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Science: ${data["Science"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Arts: ${data["Arts"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Computer: ${data["Computer"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Career: ${data["Career"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 10.h),
            Text("Great Point Average: ${data["GPA"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ClassDetails,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text("Physical Test: ${data["Physical Test"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Literature: ${data["Literature"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("English: ${data["English"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Math: ${data["Math"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Bangladesh Studies: ${data["Bangladesh Studies"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 10.h),
            Text("Physics: ${data["Physics"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Chemistry: ${data["Chemistry"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Biology: ${data["Biology"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("IT: ${data["IT"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Architecture: ${data["Architecture"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 10.h),
            Text("Fine Arts: ${data["Fine Arts"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Music: ${data["Music"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Archaeology: ${data["Archaeology"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Philosophy: ${data["Philosophy"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Psychology: ${data["Psychology"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 10.h),
            Text("Finance & Management: ${data["Finance & Management"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Marketing: ${data["Marketing"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            Text("Accounting: ${data["Accounting"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 10.h),
            Text("Great Point Average: ${data["GPA"].toStringAsFixed(2) ?? "N/A"} out of 4.00"),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ],
        ),
      );
    },
  );
}
