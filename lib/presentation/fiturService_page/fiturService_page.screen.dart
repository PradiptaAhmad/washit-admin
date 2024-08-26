import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/fiturService_page/controllers/fiturService_controller.dart';
import 'package:washit_admin/presentation/fiturService_page/models/fiturService_model.dart';

class FiturView extends StatelessWidget {
  final FiturController controller = Get.put(FiturController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Fitur'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              _showAddDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.fitur.isEmpty) {
          return Center(child: Text('No fitur available'));
        } else {
          return ListView.builder(
            itemCount: controller.fitur.length,
            itemBuilder: (context, index) {
              final fitur = controller.fitur[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    fitur.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.yellow[700]),
                        onPressed: () {
                          _showEditDialog(context, fitur);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmation(context, fitur);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Fitur',
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Fitur Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a fitur name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      textConfirm: 'Add',
      onConfirm: () {
        if (_formKey.currentState!.validate()) {
          controller.addFitur(nameController.text);
          Get.back();
          Get.snackbar('Success', 'Fitur added successfully',
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      textCancel: 'Cancel',
    );
  }

  void _showEditDialog(BuildContext context, FiturModel fitur) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    nameController.text = fitur.name;

    Get.defaultDialog(
      title: 'Edit Fitur',
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Fitur Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a fitur name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      textConfirm: 'Update',
      onConfirm: () {
        if (_formKey.currentState!.validate()) {
          controller.updateFitur(fitur.id, nameController.text);
          Get.back();
          Get.snackbar('Success', 'Fitur updated successfully',
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      textCancel: 'Cancel',
    );
  }

  void _showDeleteConfirmation(BuildContext context, FiturModel fitur) {
    Get.defaultDialog(
      title: 'Delete Fitur',
      content: Text('Are you sure you want to delete ${fitur.name}?'),
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteFitur(fitur.id);
        Get.back();
        Get.snackbar('Deleted', '${fitur.name} has been deleted',
            snackPosition: SnackPosition.BOTTOM);
      },
      textCancel: 'Cancel',
    );
  }
}