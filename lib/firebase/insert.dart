import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
final studentRef = database.child("/Student");
final resultRef = database.child("/Result");
final class_1_Ref = database.child("/one");
final class_2_Ref = database.child("/two");
final class_3_Ref = database.child("/three");
final class_4_Ref = database.child("/four");
final class_5_Ref = database.child("/five");
final class_6_Ref = database.child("/six");
final class_7_Ref = database.child("/seven");
final class_8_Ref = database.child("/eight");
final class_9_Ref = database.child("/nine");
final class_10_Ref = database.child("/ten");

final admission_ref = database.child("/Admission");

Future<void> Insert_Data(Map<String, dynamic> studentData, Map<String, dynamic> resultData,
    Map<String, dynamic> class1Data,
    Map<String, dynamic> class2Data,
    Map<String, dynamic> class3Data,
    Map<String, dynamic> class4Data,
    Map<String, dynamic> class5Data,
    Map<String, dynamic> class6Data,
    Map<String, dynamic> class7Data,
    Map<String, dynamic> class8Data,
    Map<String, dynamic> class9Data,
    Map<String, dynamic> class10Data) async {
  try {
    DataSnapshot snapshot = await studentRef.get();
    int nextId = 1;

    if (snapshot.exists) {
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> students = snapshot.value as Map<dynamic, dynamic>;
        List<int> keys = students.keys.map((key) => int.parse(key.toString())).toList();
        nextId = keys.isNotEmpty ? keys.reduce((a, b) => a > b ? a : b) + 1 : 1;
      } else if (snapshot.value is List<dynamic>) {
        List<dynamic> students = snapshot.value as List<dynamic>;
        List<int> keys = [];
        for (int i = 0; i < students.length; i++) {
          if (students[i] != null) {
            keys.add(i);
          }
        }
        nextId = keys.isNotEmpty ? keys.reduce((a, b) => a > b ? a : b) + 1 : 1;
      }
    }

    await studentRef.child(nextId.toString()).set(studentData);
    await resultRef.child(nextId.toString()).set(resultData);
    await class_1_Ref.child(nextId.toString()).set(class1Data);
    await class_2_Ref.child(nextId.toString()).set(class2Data);
    await class_3_Ref.child(nextId.toString()).set(class3Data);
    await class_4_Ref.child(nextId.toString()).set(class4Data);
    await class_5_Ref.child(nextId.toString()).set(class5Data);
    await class_6_Ref.child(nextId.toString()).set(class6Data);
    await class_7_Ref.child(nextId.toString()).set(class7Data);
    await class_8_Ref.child(nextId.toString()).set(class8Data);
    await class_9_Ref.child(nextId.toString()).set(class9Data);
    await class_10_Ref.child(nextId.toString()).set(class10Data);

  } catch (error) {
    print("Failed to add student: $error");
  }
}

Future<void> update_versity(Map<String, dynamic> versityData) async {
  try {
    DataSnapshot snapshot = await admission_ref.get();
    int nextId = 1;

    if (snapshot.exists && snapshot.value != null) {
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> versities = snapshot.value as Map<dynamic, dynamic>;
        List<int> keys = versities.keys.map((key) => int.tryParse(key.toString()) ?? 0).toList();
        nextId = keys.isNotEmpty ? keys.reduce((a, b) => a > b ? a : b) + 1 : 1;
      } else if (snapshot.value is List<dynamic>) {
        List<dynamic> versities = snapshot.value as List<dynamic>;
        List<int> keys = [];
        for (int i = 0; i < versities.length; i++) {
          if (versities[i] != null) {
            keys.add(i);
          }
        }
        nextId = keys.isNotEmpty ? keys.reduce((a, b) => a > b ? a : b) + 1 : 1;
      }
    }

    await admission_ref.child(nextId.toString()).update(versityData);
  } catch (e) {
    print("Failed to add versity details: $e");
  }
}

