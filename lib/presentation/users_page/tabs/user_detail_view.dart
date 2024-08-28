import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({
    Key? key,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.image,
    this.created,
  }) : super(key: key);

  final String? username, email, phone, address, image, created;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainpageAppbarWidget(
          title: 'Detail Pengguna',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 120,
                            width: 120,
                            child: Image.network(
                              image == null
                                  ? 'https://ui-avatars.com/api/?name=${username}&background=random&size=128'
                                  : 'https://pradiptaahmad.tech/image/${image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${username ?? "Marlen"}",
                          style: tsBodyLargeMedium(black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Aktif Sejak - ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(created.toString()))}",
                          style: tsLabelLargeMedium(darkGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text("INFORMASI PENGGUNA", style: tsBodySmallSemibold(grey)),
              SizedBox(height: 10),
              MainContainerWidget(
                padding: EdgeInsets.all(15),
                childs: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem(
                          "Email", "${email ?? "default@gmail.com"}"),
                      SizedBox(height: 10),
                      _buildDetailItem(
                        "No. Ponsel",
                        "${phone ?? "08123456789"}",
                      ),
                      SizedBox(height: 10),
                      _buildDetailItem(
                        "Alamat",
                        "Jl. Pala no 108, Binagriya Blok A, Medono, Pekalongan Barat, Pekalongan",
                      )
                    ]),
              )
            ],
          ),
        ));
  }
}

Widget _buildDetailItem(leftText, rightText) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftText,
        style: tsBodySmallMedium(grey),
      ),
      SizedBox(height: 5),
      Container(
        width: 170,
        child: Text(
          rightText,
          style: tsBodySmallMedium(darkGrey),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
