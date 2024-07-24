import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/settings_page.controller.dart';

class SettingsPageScreen extends GetView<SettingsPageController> {
  const SettingsPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsPageScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SettingsPageScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
