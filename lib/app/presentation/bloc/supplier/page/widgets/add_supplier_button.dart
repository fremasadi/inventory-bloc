import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/supplier.dart';
import '../../../../constants/app_color.dart';
import '../../supplier_bloc.dart';

class AddSupplierButton extends StatelessWidget {
  final TextEditingController _nameController;
  final TextEditingController _contactController;

  AddSupplierButton({
    required TextEditingController nameController,
    required TextEditingController contactController,
  })  : _nameController = nameController,
        _contactController = contactController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.blueLight,
      ),
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: AppColor.primary,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add New Supplier',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Supplier Name',
                        labelStyle: TextStyle(color: AppColor.white),
                      ),
                      style: TextStyle(color: AppColor.white),
                    ),
                    SizedBox(height: 16.sp),
                    TextField(
                      controller: _contactController,
                      decoration: InputDecoration(
                        labelText: 'Contact Info',
                        labelStyle: TextStyle(color: AppColor.white),
                      ),
                      style: TextStyle(color: AppColor.white),
                    ),
                    SizedBox(height: 16.sp),
                    ElevatedButton(
                      onPressed: () async {
                        String supplierName = _nameController.text;
                        String contactInfo = _contactController.text;

                        if (supplierName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Supplier name cannot be empty"),
                            ),
                          );
                          return;
                        }

                        if (contactInfo.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Contact info cannot be empty"),
                            ),
                          );
                          return;
                        }

                        Supplier newSupplier = Supplier(
                          namaSupplier: supplierName,
                          kontakSupplier: contactInfo,
                        );

                        try {
                          context
                              .read<SupplierBloc>()
                              .add(CreateSupplier(newSupplier));

                          _nameController.clear();
                          _contactController.clear();

                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Failed to create supplier: ${e.toString()}",
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.add,
          size: 28.sp,
          color: AppColor.white,
        ),
      ),
    );
  }
}
