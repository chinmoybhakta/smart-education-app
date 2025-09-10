import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service/firebase_service/checkID&Pass.dart';
import '../../admin_flow/provider/toggle_provider.dart';
import '../../auth_screen/provider/student_provider.dart';
import '../provider/result_provider.dart';
import '../provider/toggle_provider.dart';

class user_admission extends ConsumerStatefulWidget {
  const user_admission({super.key});

  @override
  ConsumerState<user_admission> createState() => _user_admissionState();
}

class _user_admissionState extends ConsumerState<user_admission> {
  TextEditingController search_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
  }

  @override
  void dispose() {
    search_controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void ReadData() async {
    try {
      DataSnapshot snapshot = await database.child("Admission/").get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value;

        if (data is List) {
          List<Map<String, dynamic>> versityList = [];
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) {
              Map<String, dynamic> versity = Map<String, dynamic>.from(data[i]);
              versity['NodeNumber'] = i;
              versityList.add(versity);
            }
          }
          ref.read(versityListProvider.notifier).state = versityList;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = ref.watch(studentNodeProvider);
    final filteredVerisities = ref.watch(filteredVersitiesProvider);
    final StudentResult = ref.watch(studentResultProvider);
    final StudentTenResult = ref.watch(classResultProvider(10));
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          SizedBox(
            width: 400.w,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Institute Name or Subject',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling if necessary
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Institute Name')),
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Required CGPA')),
                DataColumn(label: Text('Available Seats')),
                DataColumn(label: Text('Apply')),
              ],
              rows: filteredVerisities.map((versity) {
                return DataRow(
                    cells: [
                  DataCell(Center(child: Text(versity['NodeNumber'].toString()))),
                  DataCell(Center(child: Text(versity['institute']))),
                  DataCell(Center(child: Text(versity['subject']))),
                  DataCell(Center(child: Text(versity['cgpa'] != null ? versity['cgpa'].toStringAsFixed(2) : 'N/A'))),
                  DataCell(Center(child: Text(versity['seat'].toString()))),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      onPressed: () async {
                        if(versity['seat'] == 0) {
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("No Seat Available", style: TextStyle(color: Colors.red),)
                          ));
                        }
                        else if(StudentResult["eligible"] != "") {
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("You are already eligible for an institute", style: TextStyle(color: Colors.red),)
                          ));
                        }
                        else if(versity["cgpa"] <= StudentResult["CGPA"] &&
                            StudentTenResult["${versity["sub01"]}"] >= versity["sub01_gpa"] &&
                            StudentTenResult["${versity["sub02"]}"] >= versity["sub02_gpa"] &&
                            StudentTenResult["${versity["sub03"]}"] >= versity["sub03_gpa"]) {
                          final Versity_Ref = database.child("Admission/${versity["NodeNumber"]}/");
                          final Result_Ref = database.child("Result/$node/");

                          await Versity_Ref.update({"seat": versity["seat"] - 1});
                          await Result_Ref.update({"eligible" :"${versity["institute"]} ${versity["subject"]}"});
                          // setState(() {
                          //   versity["seat"] -= 1;
                          //   StudentResult["eligible"] = versity["institute"] + " " + versity["subject"];
                          // });

                          ref.read(versityListProvider.notifier).state = [
                            for (final v in ref.read(versityListProvider))
                              if (v["NodeNumber"] == versity["NodeNumber"])
                                {
                                  ...v,
                                  "seat": v["seat"] - 1,
                                }
                              else
                                v,
                          ];

                          ref.read(studentResultProvider.notifier).state['eligible'] = "${versity["institute"]} ${versity["subject"]}";
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("You are eligible", style: TextStyle(color: Colors.green),)
                          ));
                        }
                        else {
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("You are not eligible", style: TextStyle(color: Colors.red),)
                          ));
                        }
                      },
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
