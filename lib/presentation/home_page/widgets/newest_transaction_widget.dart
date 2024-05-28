import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class NewestTransactionWidget extends StatelessWidget {
  const NewestTransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Pesanan Terakhir hari ini", style: tsBodyLargeSemibold(black)),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nama akun",
                    style: tsLabelLargeSemibold(darkGrey),
                  ),
                  Text(
                    "Tanggal",
                    style: tsLabelLargeSemibold(darkGrey),
                  ),
                  Text(
                    "Via",
                    style: tsLabelLargeSemibold(darkGrey),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                decoration: BoxDecoration(color: grey),
                height: 1,
                width: double.infinity,
              ),
              SizedBox(
                height: 8,
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
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 15,
                        ),
                      ),
                      SizedBox(
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
