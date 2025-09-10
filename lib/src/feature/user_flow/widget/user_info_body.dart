import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../auth_screen/provider/student_provider.dart';
import '../../common_widget/smart_clock.dart';
import '../../common_widget/smart_inforow.dart';

class user_info extends ConsumerWidget {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StudentData = ref.watch(studentInfoProvider);
    final StudentResult = ref.watch(studentResultProvider);

    debugPrint("\n\n\n\n${StudentResult['eligible']}\n\n\n\n");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartInfoRow(label: "👋 Hello,", value: StudentData["Name"], isBold: true, fontSize: 22),
        SizedBox(height: 15.h),
        SmartInfoRow(label: "🎂 Date of Birth:", value: StudentData["Birthday"]),
        SmartInfoRow(label: "📞 Contact:", value: StudentData["Contact"]),
        SmartInfoRow(label: "📧 E-mail:", value: StudentData["E-mail"]),
        SmartInfoRow(label: "📚 Favourite Subject:", value: StudentData["Favourite Subject"]),
        SmartInfoRow(label: "🎨 Hobby:", value: StudentData["Hobby"]),
        SmartInfoRow(label: "🏫 Class:", value: "You are now in Class ${StudentData["Class"]}"),
        SizedBox(height: 20.h),
        SizedBox(height: 100.h),
        SmartClock(size: 150.h),
            SizedBox(height: 15.h),
            Text(
            "⏳ Your time is ticking...",
            style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            ),),
        SizedBox(height: 100.h),
        (StudentResult["eligible"] == "" || StudentResult["eligible"] == null) ?  const SizedBox(): SmartInfoRow(label: "Congratulation!\nYou are eligible for ", value: StudentResult["eligible"],
            isBold: true, fontSize: 22.sp
        ),
      ],
    );
  }
}

//Array--->  int x[10] = {1, 2, 3, 4};
//List---> List<int> x = [1, 2, 4];
//Map--->  Map <String, int> x = {"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50};
//List Map --> List<Map<String, int>> x = [{"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50}, {"Mango" : 20, "Jack-Fruit": 30, "Papaya": 50}];