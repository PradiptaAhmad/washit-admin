import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement UsersPageController

  final count = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;
}
