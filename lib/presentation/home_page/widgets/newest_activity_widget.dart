import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class NewestTransactionWidget extends StatelessWidget {
  const NewestTransactionWidget({
    this.mainTitle,
    this.desc1,
    this.title2,
    this.desc2,
    super.key,
  });

  final String? mainTitle, desc1, title2, desc2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mainTitle ?? "Loading...",
                      style: tsTitleSmallSemibold(darkBlue)),
                  Text("20 Riwayat", style: tsLabelLargeSemibold(darkGrey)),
                ],
              ),
              Icon(Icons.chevron_right_rounded)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nama akun",
                    style: tsLabelLargeSemibold(black),
                  ),
                  Text(
                    "Tanggal",
                    style: tsLabelLargeSemibold(black),
                  ),
                  Text(
                    "Via",
                    style: tsLabelLargeSemibold(black),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(10)),
                height: 1,
                width: double.infinity,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: grey,
                        ),
                        height: 30,
                        width: 30,
                        child: const Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Fawwaz Ahmad",
                        style: tsLabelLargeSemibold(darkGrey),
                      ),
                    ],
                  ),
                  Text(
                    "01/12/24",
                    style: tsLabelLargeSemibold(darkGrey),
                  ),
                  Text(
                    "Antar Mandiri",
                    style: tsLabelLargeSemibold(darkGrey),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
