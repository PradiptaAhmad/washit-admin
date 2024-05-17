import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [],
            ),
          ],
        ),
      ),
    )));
  }
}
