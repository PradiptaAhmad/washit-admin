import 'package:get/get.dart';
import 'package:washit_admin/presentation/history_page/controllers/detail_history.controller.dart';

class DetailHistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryController>(() => DetailHistoryController());
  }
}