import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../../../feature/admin_flow/provider/toggle_provider.dart';
import '../../../feature/auth_screen/provider/student_provider.dart';

final database = FirebaseDatabase.instance.ref();
final studentRef = database.child("/Student");

Future<bool> validateStudent(String id, String pass, ref) async {
  try {
    final snapshot = await studentRef.get();

    if (snapshot.exists && snapshot.value != null) {
      final List<dynamic> data = snapshot.value as List<dynamic>;

      // Iterate through the list safely
      for (int i = 1; i <= data.length; i++) {
        final student = data[i];
        if(student == null) continue;
        final studentMap = Map<String, dynamic>.from(student as Map);

        if (studentMap['ID'].toString() == id &&
            studentMap['Password'].toString() == pass) {
          debugPrint("MATCHED STUDENT: $studentMap");

          // Save into provider
          ref.read(studentInfoProvider.notifier).state = studentMap;
          ref.read(studentNodeProvider.notifier).state = i;
          debugPrint("\n\n\nSTUDENT ID: $i\n\n\n");
          debugPrint("\n\n\nSTUDENT ID: ${ref.watch(studentNodeProvider)}\n\n\n");
          return true;
        }
      }
    }

    return false; // no match found
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
    return false;
  }
}
