import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/core/constant/padding.dart';
import 'package:smart_edu_again/src/feature/admin_flow/provider/toggle_provider.dart';
import 'package:smart_edu_again/src/feature/admin_flow/widget/enroll_university.dart';
import 'package:smart_edu_again/src/feature/admin_flow/widget/signup_body.dart';
import 'package:smart_edu_again/src/feature/admin_flow/widget/status_body.dart';
import '../../core/routes/route_constant.dart';
import '../common_widget/smart_drawer.dart';

class AdminHomePage extends ConsumerWidget {

  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = [
      const status(),
      const signup(),
      const enroll()
    ];
    final selectedScreen = ref.watch(selectedScreenProvider);
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (context)=>IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, key: const Key("Drawer Menu"),icon: const Icon(Icons.menu)),),
          title: const Text("A New Beginning")
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const AssetImage("assets/apple_logo3.png"),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Hello Teacher!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SmartDrawer(
                    icon: Icons.person,
                    text: "Student Status",
                    onTap: (){
                      ref.read(selectedScreenProvider.notifier).state = 0;
                      context.pop();
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.school,
                    text: "New Student Sign up",
                    onTap: (){
                      ref.read(selectedScreenProvider.notifier).state = 1;
                      context.pop();
                    },
                  ),
                  SmartDrawer(
                    icon: Icons.info,
                    text: "Admission Details",
                    onTap: (){
                      ref.read(selectedScreenProvider.notifier).state = 2;
                      context.pop();
                    },
                  ),
                  const Divider(),
                  SmartDrawer(
                    icon: Icons.logout,
                    text: "Log Out",
                    color: Colors.red,
                    onTap: (){
                      context.go(RouteConst.login);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Logged out!", style: TextStyle(color: Colors.white),)
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: AppPadding.horizontalPadding,
        child: screens[selectedScreen],
      )),
    );
  }
}