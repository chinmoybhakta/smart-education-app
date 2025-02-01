import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Page/admin/result_update.dart';
import 'package:smart_education_app/feature/getter_setter.dart';

class status extends StatefulWidget {
  const status({super.key});

  @override
  State<status> createState() => _statusState();
}

class _statusState extends State<status> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
  }

  final DatabaseReference database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> students = [];

  String searchQuery = "";
  TextEditingController search_controller = TextEditingController();
  StudentIdentity SI = StudentIdentity();

  void ReadData() async {
    try {
      DataSnapshot snapshot = await database.child("Student").get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value;

        if (data is List) {
          List<Map<String, dynamic>> studentList = [];
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) {
              Map<String, dynamic> student = Map<String, dynamic>.from(data[i]);
              student['NodeNumber'] = i;
              studentList.add(student);
            }
          }

          setState(() {
            students = studentList;
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void deleteStudent(Map<String, dynamic> student) async {
    try {
      int nodeNumber = student['NodeNumber'];

      await database.child("Student/$nodeNumber").remove();
      await database.child("Result/$nodeNumber").remove();
      await database.child("one/$nodeNumber").remove();
      await database.child("two/$nodeNumber").remove();
      await database.child("three/$nodeNumber").remove();
      await database.child("four/$nodeNumber").remove();
      await database.child("five/$nodeNumber").remove();
      await database.child("six/$nodeNumber").remove();
      await database.child("seven/$nodeNumber").remove();
      await database.child("eight/$nodeNumber").remove();
      await database.child("nine/$nodeNumber").remove();
      await database.child("ten/$nodeNumber").remove();

      setState(() {
        students.removeWhere((s) => s['NodeNumber'] == nodeNumber);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${student['Name']} has been deleted.")),
      );
    } catch (e) {
      print("Error deleting student: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete ${student['Name']}.")),
      );
    }
  }

  Future<void> showConfirmationDialog(BuildContext context, Map<String, dynamic> student) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Confirmation"),
        content: Text("Are you sure you want to delete ${student['Name']}?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (result == true) {
      deleteStudent(student);
    }
  }

  List<Map<String, dynamic>> get filteredStudents {
    if (searchQuery.isEmpty) {
      return students;
    } else {
      return students.where((student) {
        return student['Name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            student['Class'].contains(searchQuery.toLowerCase()) ||
            student['NodeNumber'].toString().contains(searchQuery);
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
                    labelText: 'Search by No, Name, or Class',
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
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Class')),
                    DataColumn(label: Text('Edit')),
                    DataColumn(label: Text('Delete')),
                  ],
                  rows: filteredStudents.map((student) {
                    return DataRow(cells: [
                      DataCell(Text(student['NodeNumber'].toString())),
                      DataCell(Text(student['Name'])),
                      DataCell(Text(student['Class'])),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            SI.setIdentity(student["NodeNumber"]);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => result_update()),
                            );
                            if (result == true) {
                              setState(() {
                                ReadData(); // Refresh table only if changes were made
                              });
                            }
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showConfirmationDialog(context, student);
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
