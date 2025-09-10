import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/core/constant/padding.dart';
import 'package:smart_edu_again/src/feature/user_flow/provider/result_provider.dart';
import 'package:smart_edu_again/src/feature/user_flow/provider/toggle_provider.dart';
import 'package:smart_edu_again/src/feature/user_flow/widget/user_admission_body.dart';
import 'package:smart_edu_again/src/feature/user_flow/widget/user_info_body.dart';
import 'package:smart_edu_again/src/feature/user_flow/widget/user_result_body.dart';
import '../../core/routes/route_constant.dart';
import '../admin_flow/provider/toggle_provider.dart';
import '../auth_screen/provider/student_provider.dart';
import '../common_widget/smart_drawer.dart';

final database = FirebaseDatabase.instance.ref();

class user_home extends ConsumerStatefulWidget {
  user_home({super.key});

  @override
  ConsumerState<user_home> createState() => _user_homeState();
}

class _user_homeState extends ConsumerState<user_home> {

  @override
  void initState() {
    Future.microtask(()=>readData());
    super.initState();
  }

  Future<void> readData() async {
    debugPrint("Loading started");
    ref.read(userIsLoading.notifier).state = true;
    try{
      final node = ref.read(studentNodeProvider);

      DataSnapshot snapshot = await database.child("Result/$node/").get();
      DataSnapshot snapshot1 = await database.child("one/$node/").get();
      DataSnapshot snapshot2 = await database.child("two/$node/").get();
      DataSnapshot snapshot3 = await database.child("three/$node/").get();
      DataSnapshot snapshot4 = await database.child("four/$node/").get();
      DataSnapshot snapshot5 = await database.child("five/$node/").get();
      DataSnapshot snapshot6 = await database.child("six/$node/").get();
      DataSnapshot snapshot7 = await database.child("seven/$node/").get();
      DataSnapshot snapshot8 = await database.child("eight/$node/").get();
      DataSnapshot snapshot9 = await database.child("nine/$node/").get();
      DataSnapshot snapshot10 = await database.child("ten/$node/").get();
      if(snapshot.exists) {
        ref.read(studentResultProvider.notifier).state = Map<String, dynamic>.from(snapshot.value as Map);
      }
      if(snapshot1.exists) {
        ref.read(classResultProvider(1).notifier).state = Map<String, dynamic>.from(snapshot1.value as Map);
      }
      if(snapshot2.exists) {
        ref.read(classResultProvider(2).notifier).state = Map<String, dynamic>.from(snapshot2.value as Map);

      }
      if(snapshot3.exists) {
        ref.read(classResultProvider(3).notifier).state = Map<String, dynamic>.from(snapshot3.value as Map);
      }
      if(snapshot4.exists) {
        ref.read(classResultProvider(4).notifier).state = Map<String, dynamic>.from(snapshot4.value as Map);
      }
      if(snapshot5.exists) {
        ref.read(classResultProvider(5).notifier).state = Map<String, dynamic>.from(snapshot5.value as Map);
      }
      if(snapshot6.exists) {
        ref.read(classResultProvider(6).notifier).state = Map<String, dynamic>.from(snapshot6.value as Map);
      }
      if(snapshot7.exists) {
        ref.read(classResultProvider(7).notifier).state = Map<String, dynamic>.from(snapshot7.value as Map);
      }
      if(snapshot8.exists) {
        ref.read(classResultProvider(8).notifier).state = Map<String, dynamic>.from(snapshot8.value as Map);
      }
      if(snapshot9.exists) {
        ref.read(classResultProvider(9).notifier).state = Map<String, dynamic>.from(snapshot9.value as Map);
      }
      if(snapshot10.exists) {
        ref.read(classResultProvider(10).notifier).state = Map<String, dynamic>.from(snapshot10.value as Map);
      }

    }catch(e){
      if (kDebugMode) {
        print("Error in user info");
      }
    }
    finally {
        ref.read(userIsLoading.notifier).state = false;
        debugPrint("Loading end");
    }
  }

  List <Widget> screen = [
    user_info(),
    user_result(),
    user_admission()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (context)=>IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.menu)),),
          title: Center(child: SizedBox(height: 60.h,child: const Image(image: AssetImage("assets/book_logo.png")),)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer Header with Gradient Background
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
                    backgroundImage: const AssetImage("assets/apple_logo1.png"),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Welcome Back!",
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
              child: Consumer(
                builder: (_, ref, _) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SmartDrawer(
                        icon: Icons.person,
                        text: "Bio Data",
                        onTap: () async {
                          ref.read(userSelectedScreenProvider.notifier).state = 0;
                          context.pop();
                          await readData();
                        },
                      ),
                      SmartDrawer(
                        icon: Icons.school,
                        text: "Your Result",
                        onTap: () async {
                          ref.read(userSelectedScreenProvider.notifier).state = 1;
                          context.pop();
                          await readData();
                        },
                      ),
                      SmartDrawer(
                        icon: Icons.info,
                        text: "Admission Details",
                        onTap: () async {
                          ref.read(userSelectedScreenProvider.notifier).state = 2;
                          context.pop();
                          await readData();
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
                  );
                }
              ),
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (_, ref, _) {
          final loading = ref.watch(userIsLoading);
          final screenSelected = ref.watch(userSelectedScreenProvider);
          return ref.read(userIsLoading.notifier).state
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(child: Padding(
                padding: AppPadding.horizontalPadding,
                child: screen[screenSelected],
              ));
        }
      ),
    );
  }
}
