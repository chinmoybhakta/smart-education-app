import 'dart:math';

String generatePassword() {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';

  return List.generate(8, (index) => characters[Random().nextInt(characters.length)],).join();
}

String generateId(String name, int birthYear) {
  String initials = name.replaceAll(' ', '').substring(0, 3).toUpperCase();
  String yearPart = birthYear.toString().substring(1, 4);

  return '$initials$yearPart';
}

//Birthday - INPUT: 25-11-2002
//NAME - INPUT: ALISHA

//generateId("ALISHA", 2002)
//OUTPUT: ALI002

//Alisha jar birth year 2002 & Unique Password
