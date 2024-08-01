import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPageController extends GetxController with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  final users = <User>[].obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchUsers();
  }

  void fetchUsers() async {
    users.value = [
      User(name: 'Marlen', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '081-872-9011'),
      User(name: 'Adib', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '083-562-7721'),
      User(name: 'Abid', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '085-377-8767'),
      User(name: 'Vania', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '089-122-7121'),
      User(name: 'Daffa', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '086-882-1121'),
      User(name: 'Dika', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '084-991-7112'),
      User(name: 'Vino', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '082-770-4411'),
      User(name: 'Roro', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '087-619-0192'),
    ];
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();

  }

  void increment() => count.value++;
}

class User {
  final String name;
  final String imagePath;
  final String phoneNumber;

  User({required this.name, required this.imagePath, required this.phoneNumber});
}
