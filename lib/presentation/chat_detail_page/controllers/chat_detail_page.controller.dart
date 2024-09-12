import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';
import '../../../widget/common/custom_pop_up.dart';

class ChatDetailPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var messages = [].obs;
  var messagesData = [].obs;
  late final userId;
  var userDetailData = {}.obs;
  final box = GetStorage();
  late final WebSocketChannel? channel;

  Future<void> fetchMessageData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/admin/message/get?user_id=${userId}&page=1"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        messagesData.assignAll(jsonDecode(response.body)['data']);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data obrolan', warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addMessage(String message) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      var dataShow = {
        'to_user_id': userId.toString(),
        'from_user_id': 'admin',
        'message': message.toString(),
        'created_at': DateTime.now().toString(),
      };
      var data = {
        'user_id': userId.toString(),
        'message': message.toString(),
      };
      messagesData.add(dataShow);
      final response = await http.post(
        Uri.parse("${url}/admin/message/send"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 201) {
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, Gagal untuk mengirim pesan', warningColor);
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void subscribeToChannel() {
    var channelName = {
      "channel": "chat.admin.$userId",
    };

    if (channel != null) {
      final subscribeMessage = {
        "event": "pusher:subscribe",
        "data": channelName,
      };
      print('Subscribing: $subscribeMessage');
      channel!.sink.add(jsonEncode(subscribeMessage));

      // channel!.stream.listen((event) {
      //   print('Message received: $event');
      //   var messageData = jsonDecode(event);
      //   print(messageData);
      //   if (messageData['event'] == 'MessageSentAdmin') {
      //     var messageDetails = jsonDecode(messageData['data']);
      //     var message = messageDetails['message'];
      //     var fromUserId = messageDetails['from_user_id'];
      //     var createdAt = messageDetails['created_at'];
      //
      //     messageData.add({
      //       'message': message,
      //       'from_user_id': fromUserId,
      //       'created_at': createdAt,
      //     });
      //     update();
      //   }
      // }, onError: (error) {
      //   print('WebSocket error: $error');
      // }, onDone: () {
      //   print('WebSocket connection closed');
      // });
    }
  }

  @override
  void onInit() async {
    super.onInit();
    userId = Get.arguments[0];
    userDetailData.value = {
      'username': Get.arguments[1],
      'image_path': Get.arguments[2],
    };
    // await fetchMessageData();
    channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.laundrynaruto.my.id/app/5pmjmmvbf0kekaxxf9ks'));
    subscribeToChannel();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    channel!.sink.close();
  }

  void increment() => count.value++;
}
