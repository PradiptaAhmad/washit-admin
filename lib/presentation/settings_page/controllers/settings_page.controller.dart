import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../config.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/themes.dart';

class SettingController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var isLoading = false.obs;
  var imageFile = Rx<File?>(null);
  final adminData = {}.obs;

  GetStorage box = GetStorage();

  Future<void> fetchAdminData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/accounts/details'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['admin'];
        adminData.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    try {
      final url = ConfigEnvironments.getEnvironments()['url'];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.delete(
        Uri.parse("${url}/admin/accounts/logout"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Anda telah berhasil logout",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        box.remove('token');
        Get.offAllNamed(Routes.LOGIN_PAGE);
      } else {
        Get.snackbar("Gagal ${response.statusCode}", "Gagal logout",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  Future<void> updatePhotoProfile() async {
    try {
      final url = ConfigEnvironments.getEnvironments()['url'];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final request = http.MultipartRequest(
          'POST', Uri.parse('$url/admin/accounts/update/profile-picture'));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.value!.path,
        filename: 'image.jpg',
      ));
      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Foto profil telah berhasil diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        onRefresh();
      } else {
        Get.snackbar(
            "Gagal ${response.statusCode}", "Foto profil gagal untuk diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  Future<void> fetchUpdateAccount() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = jsonEncode({
        'username': adminData['username'],
        'email': adminData['email'],
        'phone': adminData['phone'],
      });

      final response = await http.put(
        Uri.parse('$url/admin/accounts/update'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['admin'];
        adminData.value = jsonResponse; // Update adminData with new data
        Get.snackbar("Success", "Account information updated successfully");
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await updatePhotoProfile();
    } else {
      print('No image selected.');
    }
  }

  Future<void> showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin untuk keluar dari akun?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  void updateAdminNameData() => fetchUpdateAccount();

  void updateEmailData() => fetchUpdateAccount();

  void updateAdminPhoneData() => fetchUpdateAccount();

  void updateAdminName(String newValue) {
    adminData['username'] = newValue;
  }

  void updateEmail(String newValue) {
    adminData['email'] = newValue;
  }

  void updatePhoneNumber(String newValue) {
    adminData['phone'] = newValue;
  }

  void onRefresh() async {
    isLoading.value = true;
    await fetchAdminData();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
