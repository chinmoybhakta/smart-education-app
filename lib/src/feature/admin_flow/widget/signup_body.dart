import 'package:flutter/material.dart';
import '../../../core/service/firebase_service/insert.dart';
import '../../../core/service/generate_service/generate_service.dart';
import '../../../core/service/mail_service/smart_mail_service.dart';
import '../../../core/service/validation/smart_validation.dart';
import '../../common_widget/smart_button.dart';
import '../../common_widget/smart_datepicker.dart';
import '../../common_widget/smart_dropdowns.dart';
import '../../common_widget/smart_textfield.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  late TextEditingController name_controller;
  late TextEditingController birth_controller;
  late TextEditingController mail_controller;
  late TextEditingController contact_controller;
  late TextEditingController guardian_name_controller;
  late SmartDropdownController guardian_relation_controller;
  late TextEditingController guardian_contact_controller;
  late TextEditingController hobby_controller;
  late SmartDropdownController nationality_controller;
  late SmartDropdownController gender_controller;
  late SmartDropdownController religion_controller;
  late SmartDropdownController class_controller;
  late SmartDropdownController fav_sub_controller;

  @override
  void initState() {
    name_controller = TextEditingController();
    birth_controller = TextEditingController();
    mail_controller = TextEditingController();
    contact_controller = TextEditingController();
    guardian_name_controller = TextEditingController();
    guardian_relation_controller = SmartDropdownController();
    guardian_contact_controller = TextEditingController();
    hobby_controller = TextEditingController();
    nationality_controller = SmartDropdownController();
    gender_controller = SmartDropdownController();
    religion_controller = SmartDropdownController();
    class_controller = SmartDropdownController();
    fav_sub_controller = SmartDropdownController();
    super.initState();
  }

  @override
  void dispose() {
    name_controller.dispose();
    birth_controller.dispose();
    mail_controller.dispose();
    contact_controller.dispose();
    guardian_name_controller.dispose();
    guardian_relation_controller.dispose();
    guardian_contact_controller.dispose();
    hobby_controller.dispose();
    nationality_controller.dispose();
    gender_controller.dispose();
    religion_controller.dispose();
    class_controller.dispose();
    fav_sub_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> student = {};
    Map<String, dynamic> result = {};
    Map<String, dynamic> result_class_1st = {};
    Map<String, dynamic> result_class_2nd = {};
    Map<String, dynamic> result_class_3rd = {};
    Map<String, dynamic> result_class_4th = {};
    Map<String, dynamic> result_class_5th = {};
    Map<String, dynamic> result_class_6th = {};
    Map<String, dynamic> result_class_7th = {};
    Map<String, dynamic> result_class_8th = {};
    Map<String, dynamic> result_class_9th = {};
    Map<String, dynamic> result_class_10th = {};
    List<String> formData = [];
    String s_id;
    String s_pass;

    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          width: Width * 0.8,
          child: Column(
            children: [
              SizedBox(
                height: Height * 0.05,
              ),
              const Text("NEW STUDENT FORM"),
              SizedBox(
                height: Height * 0.05,
              ),
              SmartTextfield(hintText: "Name", controller: name_controller, key: const Key("Name"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDatepicker(
                  hintText: "Date of Birth", controller: birth_controller, key: const Key("Date of Birth"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartTextfield(hintText: "E-mail", controller: mail_controller, key: const Key("E-mail"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartTextfield(
                  hintText: "Student Contact", controller: contact_controller, key: const Key("Student Contact"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartTextfield(
                  hintText: "Guardian Name",
                  controller: guardian_name_controller, key: const Key("Guardian Name"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                  key: const Key("Guardian Relation"),
                  labelText: "Guardian Relation",
                  items: const [
                    "Father",
                    "Husband",
                    "Mother",
                    "Brother",
                    "Sister",
                    "Uncle",
                    "Aunt"
                  ],
                  controller: guardian_relation_controller),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartTextfield(
                  hintText: "Guardian Contact",
                  controller: guardian_contact_controller,
                  key: const Key("Guardian Contact"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartTextfield(hintText: "Hobby", controller: hobby_controller, key: const Key("Hobby"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                  labelText: "Nationality",
                  items: const ["Bangladeshi", "Abroad"],
                  controller: nationality_controller,
                  key: const Key("Nationality"),
              ),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                  labelText: "Gender",
                  items: const ["Male", "Female", "Others"],
                  controller: gender_controller,
                  key: const Key("Gender"),
              ),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                  labelText: "Religion",
                  items: const ["Islam", "Hinduism", "Buddhism", "Other"],
                  controller: religion_controller,
                  key: const Key("Religion"),
              ),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                  labelText: "Selected Class",
                  items: const ["one", "three", "six", "nine"],
                  controller: class_controller,
                  key: const Key("Selected Class"),),
              SizedBox(
                height: Height * 0.01,
              ),
              SmartDropdown(
                key: const Key("Favourite Subject"),
                  labelText: "Favourite Subject",
                  items: const [
                    "Physical Test",
                    "Bangladesh Studies",
                    "Literature",
                    "English",
                    "Math",
                    "Information & Tech",
                    "Physics",
                    "Chemistry",
                    "Biology",
                    "Accounting",
                    "Finance",
                    "Management",
                    "Marketing",
                    "Fine Arts",
                    "Music",
                    "Digital Art",
                    "Archaeology",
                    "Philosophy",
                    "Psychology",
                    "Other",
                    "Null"
                  ],
                  controller: fav_sub_controller),
              SizedBox(
                height: Height * 0.05,
              ),
              SmartButton(
                label: "Submit",
                icon: Icons.arrow_downward,
                color: Colors.lightBlue,
                textColor: Colors.white70,
                onPressed: () {

                  formData = [
                    name_controller.text,
                    birth_controller.text,
                    mail_controller.text,
                    contact_controller.text,
                    guardian_name_controller.text,
                    guardian_relation_controller.value.toString(),
                    guardian_contact_controller.text,
                    hobby_controller.text,
                    nationality_controller.value.toString(),
                    gender_controller.value.toString(),
                    religion_controller.value.toString(),
                    class_controller.value.toString(),
                    fav_sub_controller.value.toString()
                  ];

                  s_id = formData[1] == "" ? ("") : (generateId(formData[0], int.parse(formData[1].substring(0, 4))));
                  s_pass = generatePassword();

                  if (Validate_Form(formData)) {
                    student = {
                      "Name": formData[0],
                      "Birthday": formData[1],
                      "E-mail": formData[2],
                      "Contact": formData[3],
                      "Guardian Name": formData[4],
                      "Guardian Relation": formData[5],
                      "Guardian Contact": formData[6],
                      "Hobby": formData[7],
                      "Nationality": formData[8],
                      "Gender": formData[9],
                      "Religion": formData[10],
                      "Class": formData[11],
                      "Favourite Subject": formData[12],
                      "ID": s_id,
                      "Password": s_pass
                    };

                    result_class_1st = {
                      "Physical Test" : 0.0,
                      "Bangla": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "Science" : 0.0,
                      "Arts" : 0.0,
                      "Computer" : 0.0,
                      "Career" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_2nd = {
                      "Physical Test" : 0.0,
                      "Bangla": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "Science" : 0.0,
                      "Arts" : 0.0,
                      "Computer" : 0.0,
                      "Career" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_3rd = {
                      "Physical Test" : 0.0,
                      "Bangla": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "Science" : 0.0,
                      "Arts" : 0.0,
                      "Computer" : 0.0,
                      "Career" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_4th = {
                      "Physical Test" : 0.0,
                      "Bangla": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "Science" : 0.0,
                      "Arts" : 0.0,
                      "Computer" : 0.0,
                      "Career" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_5th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_6th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_7th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_8th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_9th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result_class_10th = {
                      "Physical Test" : 0.0,
                      "Bangladesh Studies" : 0.0,
                      "Literature": 0.0,
                      "English": 0.0,
                      "Math": 0.0,
                      "IT" : 0.0,
                      "Physics": 0.0,
                      "Chemistry": 0.0,
                      "Biology": 0.0,
                      "Accounting": 0.0,
                      "Finance & Management": 0.0,
                      "Marketing": 0.0,
                      "Fine Arts": 0.0,
                      "Music": 0.0,
                      "Archaeology": 0.0,
                      "Philosophy": 0.0,
                      "Psychology": 0.0,
                      "Architecture" : 0.0,
                      "GPA" : 0.0
                    };
                    result = {
                      "1st_Lead_Subject" : "",
                      "2nd_Lead_Subject" : "",
                      "3rd_Lead_Subject" : "",
                      "1st_Lead_Subject_GPA" : 0,
                      "2nd_Lead_Subject_GPA" : 0,
                      "3rd_Lead_Subject_GPA" : 0,
                      "CGPA" : 0,
                      "one" : 0,
                      "two" : 0,
                      "three" : 0,
                      "four" : 0,
                      "five" : 0,
                      "six" : 0,
                      "seven" : 0,
                      "eight" : 0,
                      "nine" : 0,
                      "ten" : 0,
                      "eligible" : ""
                    };

                    //INSERT
                    insertData(
                        student,
                        result,
                        result_class_1st,
                        result_class_2nd,
                        result_class_3rd,
                        result_class_4th,
                        result_class_5th,
                        result_class_6th,
                        result_class_7th,
                        result_class_8th,
                        result_class_9th,
                        result_class_10th
                    );
                    sendEmail(formData[2], s_id, s_pass); //Student mail
                    student = {};

                    name_controller.clear();
                    birth_controller.clear();
                    mail_controller.clear();
                    contact_controller.clear();
                    guardian_name_controller.clear();
                    guardian_contact_controller.clear();
                    guardian_relation_controller.setDefault();
                    hobby_controller.clear();
                    nationality_controller.setDefault();
                    gender_controller.setDefault();
                    religion_controller.setDefault();
                    class_controller.setDefault();
                    fav_sub_controller.setDefault();

                    formData = [];
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Successfully Submitted!", style: TextStyle(color: Colors.green),)
                    ));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please complete the form / Invalid mail ID", style: TextStyle(color: Colors.red),)
                    ));
                  }
                },
              ),
              SizedBox(
                height: Height * 0.05,
              ),
            ],
          )),
    );
  }
}
