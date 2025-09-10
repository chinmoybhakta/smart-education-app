import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/core/constant/padding.dart';
import 'package:smart_edu_again/src/feature/auth_screen/provider/toggle_provider.dart';
import '../../core/routes/route_constant.dart';
import '../../core/service/firebase_service/checkID&Pass.dart';
import '../common_widget/smart_button.dart';
import '../common_widget/smart_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A new begining", style: TextStyle(fontSize: 32.sp, color: Colors.red),),
        leading: const Image(image: AssetImage("assets/apple_logo1.png")),
      ),
      body: Padding(
        padding: AppPadding.horizontalPadding,
        child: Center(
          child: SizedBox(
            width: 350.w,
            height: 800.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmartTextfield(
                    key: const Key('usernameField'),
                    hintText: "Username",
                    controller: userController,
                    prefixIcon: Icons.person,
                ),
                SizedBox(height: 15.h),
                Consumer(
                  builder: (_, ref, child) {
                    final obscureValidate = ref.watch(isObscureProvider);
                    final eyeIcon = obscureValidate ? Icons.visibility_off : Icons.visibility;
                    return SmartTextfield(
                      key: const Key('passwordField'),
                      hintText: "Password",
                      obscureText: obscureValidate,
                      controller: passController,
                      prefixIcon: Icons.lock,
                      suffixIcon: InkWell(
                        onTap: ()=>ref.read(isObscureProvider.notifier).state = !obscureValidate,
                        child: Icon(eyeIcon), // Ensure `eyeIcon` is of type `IconData`
                      ),
                    );
                  }
                ),
                SizedBox(height: 15.h),
                Consumer(
                  builder: (_, ref, child) {
                    final isLoading = ref.watch(isLoadingProvider);
                    return SmartButton(
                        label: "Log in",
                        icon: Icons.login,
                        isLoading: isLoading,
                        onPressed: () async {
                          if(userController.text == "chini" && passController.text == "sugar007") {
                                context.go(RouteConst.adminHome);
                                if(!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Welcome Admin", style: TextStyle(color: Colors.green),)
                                ));
                          }
                          else if(await validateStudent(userController.text, passController.text, ref)) {
                            context.go(RouteConst.userHome);
                            if(!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Successfully logged in", style: TextStyle(color: Colors.green),)
                            ));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              key: Key("INVALID"),
                                content: Text("Invalid Credentials", style: TextStyle(color: Colors.red),)
                            ));
                            ref.read(isLoadingProvider.notifier).state = true;
                            Future.delayed(Duration(seconds: 3), ()=>ref.read(isLoadingProvider.notifier).state = false);
                          }
                          userController.clear();
                          passController.clear();
                        },
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
