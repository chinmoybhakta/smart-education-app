import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth_screen/provider/student_provider.dart';

final studentNodeProvider = StateProvider<int>((ref)=>0);

final selectedScreenProvider = StateProvider<int>((ref)=> 0);

final isLoadingProvider = StateProvider<bool>((ref)=> false);

final studentStatusListProvider = StateProvider<List<Map<String, dynamic>>>((ref)=> []);

//SEARCHING PART
final searchQueryProvider = StateProvider<String>((ref)=> "");

final filteredStudentsProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final students = ref.watch(studentStatusListProvider);

  if (searchQuery.isEmpty) {
    return students;
  } else {
    return students.where((student) {
      return student['Name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          student['Class'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          student['NodeNumber'].toString().contains(searchQuery);
    }).toList();
  }
});

final calculateCGPAProvider = StateProvider<double>((ref){
  final studentResult = ref.watch(studentResultProvider);

  final gpaList = [
    studentResult['one'].toDouble(),
    studentResult['two'].toDouble(),
    studentResult['three'].toDouble(),
    studentResult['four'].toDouble(),
    studentResult['five'].toDouble(),
    studentResult['six'].toDouble(),
    studentResult['seven'].toDouble(),
    studentResult['eight'].toDouble(),
    studentResult['nine'].toDouble(),
    studentResult['ten'].toDouble()
  ];

  final countNotZeroGpa = gpaList.where((val)=>val!=0.0).length;
  final sumGpa = gpaList.fold(0.0, (pre, next)=>pre+next);

  return countNotZeroGpa == 0 ? 0.0 : sumGpa / countNotZeroGpa;
});