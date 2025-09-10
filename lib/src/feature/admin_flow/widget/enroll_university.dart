import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common_widget/smart_button.dart';
import '../../common_widget/smart_dropdowns.dart';
import '../../../core/service/firebase_service/insert.dart';
import '../../common_widget/smart_textfield.dart';
import '../../user_flow/provider/toggle_provider.dart';

class enroll extends ConsumerStatefulWidget {
  const enroll({super.key});

  @override
  ConsumerState<enroll> createState() => _admissionState();
}

class _admissionState extends ConsumerState<enroll> {
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

    final filteredVerisities = ref.watch(filteredVersitiesProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Enrolled Institutes", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10.h,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling if necessary
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Institute Name')),
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Required CGPA')),
                DataColumn(label: Text('Available Seats')),
              ],
              rows: filteredVerisities.map((versity) {
                return DataRow(
                    cells: [
                      DataCell(Center(child: Text(versity['NodeNumber'].toString()))),
                      DataCell(Center(child: Text(versity['institute']))),
                      DataCell(Center(child: Text(versity['subject']))),
                      DataCell(Center(child: Text(versity['cgpa'] != null ? versity['cgpa'].toStringAsFixed(2) : 'N/A'))),
                      DataCell(Center(child: Text(versity['seat'].toString()))),
                    ]);
              }).toList(),
            ),
          ),
          SizedBox(height: 50.h),
          Text("Enroll a new Institute", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Institute Name", controller: InstituteCon),
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Subject Name", controller: SubjectCon),
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Available Seats", controller: SeatCon),
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Required CGPA", controller: CGPACon),
          SizedBox(height: 10.h,),
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
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Required Subject 01 GPA", controller: Sub01GPACon),
          SizedBox(height: 10.h,),
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
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Required Subject 02 GPA", controller: Sub02GPACon),
          SizedBox(height: 10.h,),
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
          SizedBox(height: 10.h,),
          SmartTextfield(hintText: "Required Subject 03 GPA", controller: Sub03GPACon),
          SizedBox(height: 30.h,),
          SmartButton(label: "Confirm Enroll", onPressed: () {
            if(InstituteCon.text.isEmpty || SubjectCon.text.isEmpty || SeatCon.text.isEmpty || CGPACon.text.isEmpty || Sub01GPACon.text.isEmpty || Sub02GPACon.text.isEmpty || Sub03GPACon.text.isEmpty){
              if(!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
              updateVersity(versityData);
              if(!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          ]
        )
    );
  }
}
