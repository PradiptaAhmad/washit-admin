import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
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
                      Text(
                        "${service['nama_laundry']}",
                        style: tsBodyMediumSemibold(black),
                      ),
                      Text(
                        "${service['deskripsi']}",
                        style: tsLabelLargeSemibold(darkGrey),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Rp. ${service['harga']}",
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
                                  sheetAnimationStyle: AnimationStyle(
                                    duration: Durations.medium1,
                                    curve: Curves.easeInOut,
                                  ),
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
                                            // const SizedBox(height: 10),
                                            // InkWell(
                                            //   onTap: () {},
                                            //   splashColor: Colors.transparent,
                                            //   highlightColor:
                                            //       Colors.transparent,
                                            //   child: Row(
                                            //     children: [
                                            //       Expanded(
                                            //         child: Text(
                                            //           "Edit",
                                            //           style:
                                            //               tsBodySmallSemibold(
                                            //                   black),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .deleteFitur(service['id']);
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Hapus Fitur",
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
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
    );
  }

  // void _showDeleteConfirmation(BuildContext context, ) {
  //   Get.defaultDialog(
  //     title: 'Delete Fitur',
  //     content: Text('Are you sure you want to delete ${fitur.name}?'),
  //     textConfirm: 'Delete',
  //     confirmTextColor: Colors.white,
  //     onConfirm: () {
  //       controller.deleteFitur(fitur.id);
  //       Get.back();
  //       Get.snackbar('Deleted', '${fitur.name} has been deleted',
  //           snackPosition: SnackPosition.BOTTOM);
  //     },
  //     textCancel: 'Cancel',
  //   );
  // }

  void _showAddDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // final TextEditingController nameController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Fitur',
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Servis',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.namaLaundry.value = value;
                },
                validator: (value) {
                  controller.namaLaundry.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.harga.value = value;
                },
                validator: (value) {
                  controller.harga.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Estimasi Waktu',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.estimasiWaktu.value = value;
                },
                validator: (value) {
                  controller.estimasiWaktu.value = value!;
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.deskripsi.value = value;
                },
                validator: (value) {
                  controller.deskripsi.value = value!;
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      textConfirm: 'Add',
      onConfirm: () {
        controller.addFitur();
        Get.back();
      },
      textCancel: 'Cancel',
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
