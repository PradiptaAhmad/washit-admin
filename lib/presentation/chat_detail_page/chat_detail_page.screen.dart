import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/chat_detail_page/controllers/chat_detail_page.controller.dart';

class ChatDetailPage extends GetView<ChatDetailPageController> {
  ChatDetailPage({Key? key}) : super(key: key);
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.messages.listen((_) {
      _scrollToBottom();
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: grey,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: primaryColor,
        elevation: 1,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.network(
                'https://ui-avatars.com/api/?name=Username&background=random&size=128',
              ).image,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username', style: tsBodyLargeMedium(black)),
                Text(
                  'Online',
                  style: tsBodySmallRegular(darkGrey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Container(
                color: Colors.red,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(controller.messages[index]),
                              Text("20:22", style: tsBodySmallMedium(darkGrey)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    style: tsBodySmallMedium(black),
                    decoration: InputDecoration(
                      hintStyle: tsBodySmallMedium(darkGrey),
                      hintText: 'Type a message...',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: secondaryColor, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lightGrey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: warningColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 20,
                    color: darkGrey,
                  ),
                  onPressed: () {
                    controller.addMessage(_textController.text);
                    _textController.clear();
                  },
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
