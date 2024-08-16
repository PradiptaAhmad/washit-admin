import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:washit_admin/presentation/fiturService_page/models/fiturService_model.dart';

class FiturController extends GetxController {
  var fitur = <FiturModel>[].obs;
  var isLoading = false.obs;
  var isRefreshing = false.obs;

  final String apiUrl = '...'; // API

  @override
  void onInit() {
    super.onInit();
    fetchFitur();
  }

  Future<void> fetchFitur() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        fitur.value = data.map((e) => FiturModel.fromJson(e)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addFitur(String name) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({'name': name}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      fetchFitur();
    }
  }

  Future<void> updateFitur(int id, String name) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      body: json.encode({'name': name}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      fetchFitur();
    }
  }

  Future<void> deleteFitur(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      fetchFitur();
    }
  }
  Future<void> refreshFitur() async {
    isRefreshing(true);
    await fetchFitur();
    isRefreshing(false);
  }
}
