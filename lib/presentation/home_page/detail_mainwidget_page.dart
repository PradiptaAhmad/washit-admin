import 'package:flutter/material.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';

class DetailMainwidgetPage extends StatelessWidget {
  const DetailMainwidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Order Details"),
        centerTitle: true,
      ),
    );
  }
}
