import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/feature/splash_screen/provider/toggle.dart';

import '../../core/routes/route_constant.dart';
import '../auth_screen/login_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends ConsumerState<SplashPage> {
  List <String> apple = ["assets/apple_logo1.png", "assets/apple_logo2.png", "assets/apple_logo3.png"];
  String book = "assets/book_logo.png";
  @override
  void initState() {
    Timer(const Duration(seconds: 2), (){
      ref.read(selectedScreen.notifier).state = 1;
    });
    Timer(const Duration(seconds: 4), (){
      ref.read(selectedScreen.notifier).state = 2;
    });
    Timer(const Duration(seconds: 6), (){
      ref.read(selectedScreen.notifier).state = 0;
      context.go(RouteConst.login);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300,),
            SizedBox(height: 100,child: Image.asset(apple[ref.watch(selectedScreen)]),),
            SizedBox(height: 250, child: Image.asset(book)),
          ],
        ),
      ),
    );
  }
}
