import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  var messagesData = [].obs;
  late final userId;
  var userDetailData = {}.obs;
  final box = GetStorage();
  late final WebSocketChannel? channel;
  final ScrollController scrollController = ScrollController();
  late final Timer pingTimer;

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


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
        
        messagesData.addAll(jsonDecode(response.body)['data']);
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
        'created_at': DateTime.now().toUtc().toString(),
      };
      var data = {
        'user_id': userId.toString(),
        'message': message.toString(),
      };
      messagesData.insert(0, dataShow);
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
      channel!.sink.add(jsonEncode(subscribeMessage));
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
    await fetchMessageData();
    pingTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      sendPing();
    });

  }

  void sendPing() {
    if (channel != null) {
      final pingMessage = {
        "event": "pusher:ping",
        "data": {},
      };
      channel!.sink.add(jsonEncode(pingMessage));
      print(channel!.stream);
    }
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
