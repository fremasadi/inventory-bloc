import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/bloc/category/category_bloc.dart';
import 'package:inventory/app/presentation/constants/app_color.dart';

import '../../data/models/category.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.white,
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColor.white,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          IconButton(
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
                          // Mengaitkan controller
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
                                      content: Text(
                                          "Category name cannot be empty")));
                              return;
                            }
                            Category newCategory =
                                Category(namaKategori: categoryName);

                            try {
                              context
                                  .read<CategoryBloc>()
                                  .add(CreateCategory(newCategory));

                              // Kosongkan input setelah submit
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
          )
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            final categories = state.categories;

            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: AppColor.primary,
                      context: context,
                      builder: (BuildContext context) {
                        final TextEditingController editCategoryController =
                            TextEditingController(
                                text: categories[index].namaKategori);
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Edit Category',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                              SizedBox(height: 16.sp),
                              TextField(
                                controller: editCategoryController,
                                decoration: InputDecoration(
                                  labelText: 'Category Name',
                                  labelStyle: TextStyle(color: AppColor.white),
                                ),
                                style: TextStyle(color: AppColor.white),
                              ),
                              SizedBox(height: 16.sp),
                              ElevatedButton(
                                onPressed: () {
                                  String updatedCategoryName =
                                      editCategoryController.text;
                                  if (updatedCategoryName.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Category name cannot be empty")));
                                    return;
                                  }
                                  Category updatedCategory = Category(
                                    id: categories[index].id,
                                    namaKategori: updatedCategoryName,
                                  );
                                  context
                                      .read<CategoryBloc>()
                                      .add(EditCategory(updatedCategory));
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.green,
                                ),
                                child: Text(
                                  'Update',
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
                  child: ListTile(
                    title: Text(
                      categories[index].namaKategori,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.category,
                      color: AppColor.yellow,
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
            );
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}
