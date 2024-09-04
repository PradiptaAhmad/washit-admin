import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/widget/auth/input_form_widget.dart';

import '../../../infrastructure/theme/themes.dart';
import '../controllers/transaction_page.controller.dart';

class UpdateWeightBottomSheet extends StatefulWidget {
  @override
  _UpdateWeightBottomSheetState createState() =>
      _UpdateWeightBottomSheetState();
}

class _UpdateWeightBottomSheetState extends State<UpdateWeightBottomSheet> {
  final _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TransactionPageController _controller =
      Get.find<TransactionPageController>();

  void _updateWeight() async {
    if (_formKey.currentState!.validate()) {
      final weight = double.tryParse(_weightController.text);
      if (weight != null) {
        await _controller.updateLaundryWeight(weight);
        Navigator.pop(context);
      } else {
        Get.snackbar('Error', 'Invalid weight');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(defaultMargin),
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: lightGrey.withOpacity(0.5)),
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.close_rounded,
                                color: grey,
                                size: 18,
                              )))),
                  SizedBox(width: 5),
                  Text("Update Berat Laundry",
                      style: tsBodySmallSemibold(black)),
                ],
              ),
              InputFormWidget(
                formKey: _formKey,
                title: 'Berat Laundry (Kg)',
                controller: _weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Berat Laundry';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan Berat Laundry yang Valid';
                  }
                  return null;
                },
                // key: _formKey,
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: _updateWeight,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  child: Center(
                    child: Text("Update Berat Laundry",
                        style: tsBodySmallSemibold(primaryColor)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
