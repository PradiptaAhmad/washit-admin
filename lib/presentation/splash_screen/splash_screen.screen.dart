import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../infrastructure/navigation/routes.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({super.key});

  @override
  State<SplashScreenScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (box.read('token') != null) {
        Get.offNamed(Routes.NAVBAR);
      } else {
        Get.offNamed(Routes.LOGIN_PAGE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/icons/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
