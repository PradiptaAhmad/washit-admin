import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home_page.controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePageScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomePageScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
