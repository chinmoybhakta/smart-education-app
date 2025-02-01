import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Page/user/user_result_body.dart';

import '../../firebase/checkID&Pass.dart';

class user_admission extends StatefulWidget {
  const user_admission({super.key});

  @override
  State<user_admission> createState() => _user_admissionState();
}

class _user_admissionState extends State<user_admission> {
  int node = SI.getIdentity();
  List<Map<String, dynamic>> versities = [];
  Map<String, dynamic> StudentResult = SI.getResultData();
  Map<String, dynamic> StudentTenResult = SI.getTenData();
  String searchQuery = "";
  TextEditingController search_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
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

          setState(() {
            versities = versityList;
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  List<Map<String, dynamic>> get filteredStudents {
    if (searchQuery.isEmpty) {
      return versities;
    } else {
      return versities.where((versity) {
        return versity['institute'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            versity['subject'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 16),
            SizedBox(
              width: 400,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search by Institute Name or Subject',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow horizontal scrolling if necessary
              child: DataTable(
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Institute Name')),
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Required'
                      ' CGPA')),
                  DataColumn(label: Text('Apply')),
                ],
                rows: filteredStudents.map((versity) {
                  return DataRow(cells: [
                    DataCell(Text(versity['NodeNumber'].toString())),
                    DataCell(Text(versity['institute'])),
                    DataCell(Text(versity['subject'])),
                    DataCell(Text(versity['cgpa'] != null ? versity['cgpa'].toStringAsFixed(2) : 'N/A')),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        onPressed: () async {
                          if(versity['seat'] == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Seat Available", style: TextStyle(color: Colors.red),)
                            ));
                          }
                          else if(versity["seat"] != 0 && StudentResult["eligible"] == "" &&
                              versity["cgpa"] <= StudentResult["CGPA"] &&
                              StudentTenResult["${versity["sub01"]}"] >= versity["sub01_gpa"] &&
                              StudentTenResult["${versity["sub02"]}"] >= versity["sub02_gpa"] &&
                              StudentTenResult["${versity["sub03"]}"] >= versity["sub03_gpa"]) {
                            final Versity_Ref = database.child("Admission/${versity["NodeNumber"]}/");
                            final Result_Ref = database.child("Result/${node}/");
                            
                            await Versity_Ref.update({"seat": versity["seat"] - 1});
                            await Result_Ref.update({"eligible" : versity["institute"] + " " + versity["subject"]});
                            setState(() {
                              versity["seat"] -= 1;
                              StudentResult["eligible"] = versity["institute"] + " " + versity["subject"];
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("You are eligible", style: TextStyle(color: Colors.green),)
                            ));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      ),
    );
  }
}
