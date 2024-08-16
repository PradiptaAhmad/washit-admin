import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';

class UserTabView extends GetView<UsersPageController> {
  const UserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CupertinoActivityIndicator());
      } else {
        return ListView.builder(
          itemCount: controller.userData.length,
          itemBuilder: (context, index) {
            final user = controller.userData[index];
            return Container(
              margin: EdgeInsets.only(
                  bottom: 10, right: defaultMargin, left: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: lightGrey, width: 1),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: grey,
                    backgroundImage: NetworkImage(user['image_path'] == null
                        ? 'https://ui-avatars.com/api/?name=${user['username']}&background=random&size=128'
                        : 'https://pradiptaahmad.tech/image/${user['image_path']}'),
                  ),
                  SizedBox(width: 12),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(user['username'],
                                style: tsBodyMediumMedium(black)),
                            SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                            "Bergabung pada tanggal ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(user['created_at'].toString()))}",
                            style: tsLabelLargeMedium(darkGrey)),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 20,
                      ))
                ],
              ),
            );
          },
        );
      }
    });
  }
}
