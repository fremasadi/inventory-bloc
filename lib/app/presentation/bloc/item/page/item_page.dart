import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/bloc/item/page/add_item_page.dart';
import 'package:inventory/app/presentation/bloc/item/page/edit_item_page.dart';

import '../../../../core/models/category.dart';
import '../../../../core/models/item.dart';
import '../../../constants/app_color.dart';
import '../../category/category_bloc.dart';
import '../../category/category_state.dart';
import '../item_bloc.dart';
import '../item_event.dart';
import '../item_state.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.blueLight,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddItemPage()));
          },
          icon: Icon(
            Icons.add,
            size: 28.sp,
            color: AppColor.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * .1),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  if (state is ItemLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ItemLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return _buildItemList(context, item);
                      },
                    );
                  } else if (state is ItemError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return const Center(child: Text('Tidak ada item'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(BuildContext context, Item item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(16.sp)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.namaBarang,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'Stock : ${item.stok}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _showItemDetailDialog(context, item);
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  size: 28.sp,
                  color: AppColor.yellow,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItemPage(item: item),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  size: 28.sp,
                  color: Colors.greenAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<ItemBloc>().add(DeleteItem(item.id!));
                },
                icon: Icon(
                  Icons.restore_from_trash,
                  size: 28.sp,
                  color: Colors.redAccent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showItemDetailDialog(BuildContext context, Item item) {
    final categoryState = context.read<CategoryBloc>().state;

    String categoryName = '';
    if (categoryState is CategoryLoaded) {
      final Category category = categoryState.categories
          .firstWhere((cat) => cat.id == item.kategoriId);
      categoryName = category.namaKategori;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColor.secondary,
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item: ${item.namaBarang}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Deskripsi: ${item.deskripsi}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Stock: ${item.stok}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Harga: Rp.${item.harga}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Kategori: $categoryName',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Supplier: ${item.supplierId}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
