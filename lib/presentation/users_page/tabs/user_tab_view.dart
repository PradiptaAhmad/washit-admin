import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

class UserTabView extends GetView<UsersPageController> {
  const UserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.onRefresh(),
      child: SingleChildScrollView(
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
                onChanged: (value) {
                  controller.filteredUserData.value = controller.userData
                      .where((user) => user['username']
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                },
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return _shimmerItemList();
                  },
                );
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.filteredUserData.length,
                itemBuilder: (context, index) {
                  final user = controller.filteredUserData[index];
                  return _buildItemList(user);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget _shimmerItemList() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: ShimmerWidget(
      radius: 10.00,
      margin: 15.00,
      height: 72,
    ),
  );
}

Widget _buildItemList(user) {
  return MainContainerWidget(
    onPressed: () =>
        Get.toNamed(Routes.USER_DETAIL_PAGE, arguments: user['id']),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    padding: EdgeInsets.all(15),
    childs: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            backgroundColor: grey,
            backgroundImage: NetworkImage(user['image_path'] == null
                ? 'https://ui-avatars.com/api/?name=${user['username']}&background=random&size=128'
                : 'https://api.laundrynaruto.my.id/image/${user['image_path']}'),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user['username']}",
                style: tsBodySmallMedium(black),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 5),
              Text(
                "Bergabung tanggal ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(user['created_at'].toString()))}",
                style: tsLabelLargeMedium(darkGrey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
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
