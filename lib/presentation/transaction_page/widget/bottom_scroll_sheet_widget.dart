import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Text(
                'Update Berat Laundry',
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Berat Laundry (Kg)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan Berat Laundry';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Masukkan Berat Laundry yang Valid';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateWeight,
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
