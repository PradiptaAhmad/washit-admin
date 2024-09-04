import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/dal/services/currency_formatter.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/fiturService_page/components/fitur_textfield.dart';
import 'package:washit_admin/presentation/fiturService_page/controllers/fiturService_controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';

class FiturView extends GetView<FiturController> {
  // final FiturController controller = Get.put(FiturController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Manajemen Servis',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CupertinoActivityIndicator());
        } else if (controller.serviceList.length == 0) {
          return Center(child: Text('No fitur available'));
        } else {
          return RefreshIndicator(
            onRefresh: controller.refreshFitur,
            child: ListView.builder(
              itemCount: controller.serviceList.length,
              itemBuilder: (context, index) {
                final service = controller.serviceList[index];
                return MainContainerWidget(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(15),
                  childs: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${service['nama_laundry']}",
                            style: tsBodyMediumSemibold(black),
                          ),
                          Spacer(),
                          service['is_active']
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: secondaryColor.withOpacity(0.2)),
                                  child: Text("Aktif",
                                      style:
                                          tsLabelMediumMedium(secondaryColor)))
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: warningColor.withOpacity(0.2)),
                                  child: Text("Tidak Aktif",
                                      style: tsLabelMediumMedium(warningColor)))
                        ],
                      ),
                      Text(
                        "${service['deskripsi']}",
                        style: tsLabelLargeSemibold(darkGrey),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "${controller.formatPrice(service['harga'].toString())}",
                              style: tsBodySmallSemibold(secondaryColor),
                            ),
                            Spacer(),
                            MainContainerWidget(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  enableDrag: true,
                                  isDismissible: true,
                                  scrollControlDisabledMaxHeightRatio: 0.45,
                                  // sheetAnimationStyle: AnimationStyle(
                                  //   duration: Durations.medium1,
                                  //   curve: Curves.easeInOut,
                                  // ),
                                  backgroundColor: primaryColor,
                                  isScrollControlled: true,
                                  // Ensure the modal can grow with the keyboard
                                  builder: (context) {
                                    // Retrieve the keyboard height
                                    final double keyboardHeight =
                                        MediaQuery.of(context)
                                            .viewInsets
                                            .bottom;

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: keyboardHeight),
                                      child: Container(
                                        width: double.infinity,
                                        padding:
                                            const EdgeInsets.all(defaultMargin),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () => Get.back(),
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .updateServis(service);
                                                Get.back();
                                                _showAddDialog(context, "edit",
                                                    service['id']);
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent, 
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Edit Servis",
                                                      style:
                                                          tsBodySmallSemibold(
                                                              darkGrey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                _showDeleteConfirmation(
                                                    context, service);
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Hapus Servis",
                                                      style:
                                                          tsBodySmallSemibold(
                                                              warningColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              childs: Icon(
                                Icons.more_horiz_rounded,
                                color: black,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context, 'add', null);
        },
        child: Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, dynamic fitur) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
              'Apakah Anda yakin ingin menghapus fitur ${fitur['nama_laundry']}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                controller.deleteFitur(fitur['id']);
                Navigator.of(dialogContext).pop();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog(BuildContext context, String mode, int? laundryId) {
    final _formKey = GlobalKey<FormState>();
    // final TextEditingController nameController = TextEditingController();

    Get.defaultDialog(
      title: mode == "add" ? 'Tambah Layanan' : 'Edit Layanan',
      titlePadding: EdgeInsets.only(top: 20, left: 15, right: 15),
      titleStyle: tsTitleSmallMedium(black),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FiturTextField(
                hintText: 'Nama Servis',
                controller: controller.namaLaundryController,
                onChanged: (value) {
                  controller.namaLaundry.value = value;
                },
                validator: (value) {
                  controller.namaLaundry.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              FiturTextField(
                hintText: 'Harga',
                controller: controller.hargaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter()
                ],
                onChanged: (value) {
                  controller.harga.value = controller.hargaController.text
                      .replaceAll(RegExp(r'[^0-9]'), '');
                },
                validator: (value) {
                  controller.harga.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              FiturTextField(
                hintText: 'Estimasi Waktu',
                controller: controller.estimasiWaktuController,
                onChanged: (value) {
                  controller.estimasiWaktu.value = value;
                },
                validator: (value) {
                  controller.estimasiWaktu.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              FiturTextField(
                hintText: 'Deskripsi',
                controller: controller.deskripsiController,
                onChanged: (value) {
                  controller.deskripsi.value = value;
                },
                validator: (value) {
                  controller.deskripsi.value = value!;
                  return null;
                },
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: lightGrey)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Status',
                        style: tsBodyMediumMedium(black),
                      ),
                    ),
                    Obx(
                      () => CupertinoSwitch(
                        value: controller.status.value,
                        activeColor: secondaryColor,
                        onChanged: (value) {
                          controller.status.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (mode == "add") {
                        controller.addFitur();
                      } else {
                        controller.updateFitur(laundryId!);
                      }
                      Get.back();
                    },
                    child: Container(
                      width: screenWidth(context) * 0.25,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(mode == "add" ? 'Tambah' : 'Edit',
                          style: tsBodySmallSemibold(primaryColor)),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: screenWidth(context) * 0.25,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Batal', style: tsBodySmallSemibold(black)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// void _showEditDialog(BuildContext context, FiturModel fitur) {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//
//   nameController.text = fitur.name;
//
//   Get.defaultDialog(
//     title: 'Edit Fitur',
//     content: Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 labelText: 'Fitur Name',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a fitur name';
//                 }
//                 return null;
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//     textConfirm: 'Update',
//     onConfirm: () {
//       if (_formKey.currentState!.validate()) {
//         // controller.updateFitur(fitur.id, nameController.text);
//         Get.back();
//         Get.snackbar('Success', 'Fitur updated successfully',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     },
//     textCancel: 'Cancel',
//   );
// }
}
