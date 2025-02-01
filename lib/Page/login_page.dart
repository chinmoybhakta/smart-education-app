import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_education_app/Page/admin/home_page.dart';
import 'package:smart_education_app/Page/user/user_home_page.dart';
import 'package:smart_education_app/Widget/smart_button.dart';
import 'package:smart_education_app/Widget/smart_textfield.dart';
import 'package:smart_education_app/feature/getter_setter.dart';
import 'package:smart_education_app/firebase/checkID&Pass.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController user_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  StudentIdentity SI = StudentIdentity();
  bool is_loading = false;

  bool obsecureValidate = true;
  IconData eyeIcon = Icons.visibility_off;

  void obsecureValidity(){
    setState(() {
      obsecureValidate = !obsecureValidate;
      eyeIcon = obsecureValidate ? Icons.visibility_off : Icons.visibility;
    });
  }
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("A new begining", style: TextStyle(fontSize: 40, color: Colors.red),),
        leading: Image(image: AssetImage("assets/apple_logo1.png")),
      ),
      body: Center(
        child: Container(
          width: Width*0.8,
          height: Height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartTextfield(
                  hintText: "Username",
                  controller: user_controller,
                  prefixIcon: Icons.person,
              ),
              SizedBox(height: 15),
              SmartTextfield(
                hintText: "Password",
                obscureText: obsecureValidate,
                controller: pass_controller,
                prefixIcon: Icons.lock,
                suffixIcon: InkWell(
                  onTap: obsecureValidity, // Call the function to toggle visibility
                  child: Icon(eyeIcon), // Ensure `eyeIcon` is of type `IconData`
                ),

              ),
              SizedBox(height: 15),
              SmartButton(
                  label: "Log in",
                  icon: Icons.login,
                  isLoading: is_loading,
                  onPressed: () async {
                    setState(() {
                      is_loading = true;
                    });
                    if(user_controller.text == "chini" && pass_controller.text == "sugar007") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Welcome Admin", style: TextStyle(color: Colors.green),)
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                    }
                    else if(await validateStudent(user_controller.text, pass_controller.text)) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>user_home()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Successfully logged in", style: TextStyle(color: Colors.green),)
                      ));
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid Credentials", style: TextStyle(color: Colors.red),)
                      ));
                    }
                    user_controller.clear();
                    pass_controller.clear();
                    Timer(Duration(seconds: 2), () {
                      setState(() {
                        is_loading = false;
                      });
                    });
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
