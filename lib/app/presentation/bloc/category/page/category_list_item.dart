import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/category.dart';
import '../../../constants/app_color.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final Function(Category) onEdit;
  final Function(int) onDelete; // Tambahkan fungsi untuk menghapus kategori

  const CategoryListItem({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete, // Tambahkan fungsi untuk menghapus kategori
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColor.secondary,
              title: Text(
                'Konfirmasi Hapus?',
                style: TextStyle(fontSize: 18.sp, color: AppColor.white),
              ),
              content: Text(
                'Apakah Anda yakin ingin menghapus kategori ini?',
                style: TextStyle(fontSize: 14.sp, color: AppColor.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary,
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onDelete(category.id!); // Panggil fungsi delete
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna tombol delete
                  ),
                  child: Text(
                    'Hapus',
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: ListTile(
        title: Text(
          category.namaKategori,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.white,
          ),
        ),
        leading: Icon(
          Icons.category,
          color: AppColor.yellow,
        ),
        trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: AppColor.primary,
              context: context,
              builder: (BuildContext context) {
                final TextEditingController editCategoryController =
                    TextEditingController(text: category.namaKategori);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit Kategory',
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
                          labelText: 'Nama Kategory',
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
                                content:
                                    Text("Nama kategori tidak boleh kosong"),
                              ),
                            );
                            return;
                          }
                          Category updatedCategory = Category(
                            id: category.id,
                            namaKategori: updatedCategoryName,
                          );
                          onEdit(updatedCategory);
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
          icon: Icon(
            Icons.edit,
            size: 22.sp,
            color: AppColor.green,
          ),
        ),
      ),
    );
  }
}
