import 'package:get/get.dart';
import 'package:washit_admin/presentation/history_transaction_page/controllers/history_transaction_page.controller.dart';

class HistoryTransactionPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTransactionPageController>(
        () => HistoryTransactionPageController());
  }
}
