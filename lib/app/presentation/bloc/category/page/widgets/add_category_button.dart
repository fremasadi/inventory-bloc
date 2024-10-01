import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/category.dart';
import '../../../../constants/app_color.dart';
import '../../category_bloc.dart';
import '../../category_event.dart';

class AddCategoryButton extends StatelessWidget {
  final TextEditingController categoryController;

  AddCategoryButton({required this.categoryController});

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
                      'Add New Category',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        labelStyle: TextStyle(color: AppColor.white),
                      ),
                      style: TextStyle(color: AppColor.white),
                    ),
                    SizedBox(height: 16.sp),
                    ElevatedButton(
                      onPressed: () async {
                        String categoryName = categoryController.text;
                        if (categoryName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Category name cannot be empty")));
                          return;
                        }
                        Category newCategory =
                            Category(namaKategori: categoryName);

                        try {
                          context
                              .read<CategoryBloc>()
                              .add(CreateCategory(newCategory));

                          categoryController.clear();
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Gagal Membuat category category: ${e.toString()}")));
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
