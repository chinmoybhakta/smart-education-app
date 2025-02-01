import 'package:firebase_database/firebase_database.dart';
import 'package:smart_education_app/feature/getter_setter.dart';
final database = FirebaseDatabase.instance.ref();
final studentRef = database.child("/Student");

Future<bool> validateStudent(String id, String pass) async {
  StudentIdentity SI = StudentIdentity();
  int index;
  try {
    final snapshot = await studentRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final data = snapshot.value;

      if (data is List) {
        // Filter out null entries from the list
        final students = data.where((student) => student != null).toList();

        index = 1;
        for (var student in students) {
          if (student['ID'] == id && student['Password'] == pass) {
            SI.setIdentity(index);
            return true;
          }
          index++;
        }
      }
    }

    // Return false if no match is found
    return false;
  } catch (e) {
    print("Error: $e"); // Log the error
    return false; // Handle error by returning false
  }
}