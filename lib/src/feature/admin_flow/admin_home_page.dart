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
import '../user_flow/provider/toggle_provider.dart';

class AdminHomePage extends ConsumerStatefulWidget {

  const AdminHomePage({super.key});

  @override
  ConsumerState<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends ConsumerState<AdminHomePage> {

  final DatabaseReference database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    Future.microtask(()=>readData());
    super.initState();
  }

  Future<void>readData() async{
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      DataSnapshot snapshot1 = await database.child("Student").get();

      if (snapshot1.exists && snapshot1.value != null) {
        final data = snapshot1.value;

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

        DataSnapshot snapshot2 = await database.child("Admission/").get();

        if (snapshot2.exists && snapshot2.value != null) {
          final data = snapshot2.value;

          if (data is List) {
            List<Map<String, dynamic>> versityList = [];
            for (int i = 0; i < data.length; i++) {
              if (data[i] != null) {
                Map<String, dynamic> versity = Map<String, dynamic>.from(data[i]);
                versity['NodeNumber'] = i;
                versityList.add(versity);
              }
            }
            ref.read(versityListProvider.notifier).state = versityList;
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
    finally{
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
