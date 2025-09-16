import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../auth_screen/provider/toggle_provider.dart';
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
  late TextEditingController InstituteCon;
  late TextEditingController SubjectCon;
  late TextEditingController SeatCon;
  late TextEditingController CGPACon;
  late SmartDropdownController Sub01Con;
  late SmartDropdownController Sub02Con;
  late SmartDropdownController Sub03Con;
  late TextEditingController Sub01GPACon;
  late TextEditingController Sub02GPACon;
  late TextEditingController Sub03GPACon;

  @override
  void initState() {
    InstituteCon = TextEditingController();
    SubjectCon = TextEditingController();
    SeatCon = TextEditingController();
    CGPACon = TextEditingController();
    Sub01Con = SmartDropdownController();
    Sub02Con = SmartDropdownController();
    Sub03Con = SmartDropdownController();
    Sub01GPACon = TextEditingController();
    Sub02GPACon = TextEditingController();
    Sub03GPACon = TextEditingController();
    Future.microtask(()=>readInstitute());
    super.initState();
  }

  @override
  void dispose() {
    InstituteCon.dispose();
    SubjectCon.dispose();
    SeatCon.dispose();
    CGPACon.dispose();
    Sub01Con.dispose();
    Sub02Con.dispose();
    Sub03Con.dispose();
    Sub01GPACon.dispose();
    Sub02GPACon.dispose();
    Sub03GPACon.dispose();
    super.dispose();
  }

  Future<void> readInstitute() async{
    ref.read(isLoadingProvider.notifier).state = true;
    Future.delayed(const Duration(seconds: 5));

    DataSnapshot snapshot2 = await database.child("Admission/").get();

    try{
      if (snapshot2.exists && snapshot2.value != null) {
        final data = snapshot2.value;

        if (data is List) {
          List<Map<String, dynamic>> versityList = [];
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) {
              Map<String, dynamic> versity = Map<String, dynamic>.from(data[i]);
              versity['NodeNumber'] = i;
              versityList.add(versity);
            }
          }
          ref
              .read(versityListProvider.notifier)
              .state = versityList;
        }
      }
    }catch (e) {
      debugPrint("Error fetching data: $e");
    }
    finally{
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    final loadingState = ref.watch(isLoadingProvider);
    final filteredVerisities = ref.watch(filteredVersitiesProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Enrolled Institutes", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10.h,),
          loadingState ? const CircularProgressIndicator() : SingleChildScrollView(
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
          SmartButton(label: "Confirm Enroll", onPressed: () async {
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
              await updateVersity(versityData);
              await readInstitute();
              if(!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Successfully added", style: TextStyle(color: Colors.green),)
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
