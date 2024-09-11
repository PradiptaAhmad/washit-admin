import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/chat_page/controllers/chat_page.controller.dart';

import '../../infrastructure/theme/themes.dart';

class ChatPage extends GetView<ChatPageController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('Percakapan Pengguna',
            style: tsTitleSmallMedium(primaryColor)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return null;
        },
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Get.toNamed(Routes.CHAT_DETAIL_PAGE),
            child: _buildItemList(),
          ),
        ),
      ),
    );
  }
}

Widget _buildItemList() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(100),
          ),
          width: 45,
          height: 45,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Marlen Edzel Satriani',
                        style: tsBodySmallMedium(black),
                      ),
                    ),
                    Text(
                      '31/23/12',
                      style: tsLabelLargeMedium(darkGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'orang 1 uses a default timer for dissapear and come again lol',
                  style: tsLabelLargeMedium(darkGrey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
