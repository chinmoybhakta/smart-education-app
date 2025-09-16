import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/feature/auth_screen/provider/student_provider.dart';
import '../../../core/routes/route_constant.dart';
import '../provider/toggle_provider.dart';

class status extends ConsumerStatefulWidget {
  const status({super.key});

  @override
  ConsumerState<status> createState() => _statusState();
}

class _statusState extends ConsumerState<status> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    Future.microtask(() => readData());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //READ
  Future<void> readData() async {
    ref.read(isLoadingProvider.notifier).state = true;
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

          ref.read(studentStatusListProvider.notifier).state = studentList;
        }
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
    finally{
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  //DELETE
  void deleteStudent(Map<String, dynamic> student, ref) async {
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

      ref
          .read(studentStatusListProvider.notifier)
          .state
          .removeWhere((s) => s['NodeNumber'] == nodeNumber);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${student['Name']} has been deleted.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete ${student['Name']}.")),
      );
    }
  }

  Future<void> showConfirmationDialog(
      BuildContext context,
      Map<String, dynamic> student,
      ref,
      ) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
        title: const Text("Delete Confirmation"),
        content: Text(
          "Are you sure you want to delete ${student['Name']}?",
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => context.pop(false),
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () => context.pop(true),
          ),
        ],
      ),
    );

    if (result == true) {
      deleteStudent(student, ref);
      await readData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudentList = ref.watch(filteredStudentsProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          SizedBox(
            width: 400.w,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by No, Name, or Class',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
                debugPrint(
                  "\n\n\n\n${filteredStudentList[1]['Class']}\n\n\n\n",
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection:
            Axis.horizontal, // Allow horizontal scrolling if necessary
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Class')),
                DataColumn(label: Text('Edit')),
                DataColumn(label: Text('Delete')),
              ],
              rows:
              filteredStudentList.map((student) {
                return DataRow(
                  cells: [
                    DataCell(Text(student['NodeNumber'].toString())),
                    DataCell(Text(student['Name'])),
                    DataCell(Text(student['Class'])),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          ref.read(studentNodeProvider.notifier).state =
                              student["NodeNumber"].toInt();
                          ref.read(studentInfoProvider.notifier).state =
                              student;

                          if (student['Class'] == 'admission') {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${student["Name"]} has passed all classes. Its time for admit a desired university/institute",
                                  style: const TextStyle(
                                    color: Colors.indigoAccent,
                                  ),
                                ),
                              ),
                            );
                          } else if (student['Class'] == "one" ||
                              student['Class'] == "two" ||
                              student['Class'] == "three" ||
                              student['Class'] == "four") {
                            await context.push(RouteConst.resultUpdate1);
                          } else {
                            await context.push(RouteConst.resultUpdate2);
                          }

                          await readData();
                        },
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showConfirmationDialog(context, student, ref);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}