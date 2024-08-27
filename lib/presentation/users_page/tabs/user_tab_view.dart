import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';
import 'package:washit_admin/presentation/users_page/tabs/user_detail_view.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

class UserTabView extends GetView<UsersPageController> {
  const UserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: CupertinoSearchTextField(
              style: tsBodySmallMedium(black),
              padding: EdgeInsets.all(10),
              prefixInsets: EdgeInsets.only(left: 10),
              suffixInsets: EdgeInsets.only(right: 10),
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.userData.length,
            itemBuilder: (context, index) {
              final user = controller.userData[index];
              return _buildItemList(user);
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildItemList(user) {
  return MainContainerWidget(
    onPressed: () => Get.to(() => UserDetailView(
          email: user['email'],
          username: user['username'],
          phone: user['phone'],
          address: user['address'],
          image: user['image_path'],
          created: user['created_at'],
        )),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    padding: EdgeInsets.all(15),
    childs: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: grey,
              backgroundImage: NetworkImage(user['image_path'] == null
                  ? 'https://ui-avatars.com/api/?name=${user['username']}&background=random&size=128'
                  : 'https://pradiptaahmad.tech/image/${user['image_path']}'),
            ),
            SizedBox(width: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(user['username'], style: tsBodySmallMedium(black)),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                      "Bergabung tanggal ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(user['created_at'].toString()))}",
                      style: tsLabelLargeMedium(darkGrey)),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Container(
            child: Icon(
              Icons.more_vert_rounded,
              size: 20,
              color: darkGrey,
            ),
          ),
        )
      ],
    ),
  );
}
