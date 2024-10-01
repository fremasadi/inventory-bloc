import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/constants/app_color.dart';
import '../../../../core/models/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../item_bloc.dart';
import '../item_event.dart';

class EditItemPage extends StatelessWidget {
  final Item item;

  const EditItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = item.namaBarang;
    String description = item.deskripsi;
    String stock = item.stok.toString();
    String price = item.harga.toString();

    void updateItem() {
      if (formKey.currentState!.validate()) {
        final updatedItem = Item(
          id: item.id,
          namaBarang: name,
          deskripsi: description,
          stok: int.parse(stock),
          harga: double.parse(price),
          kategoriId: item.kategoriId,
          supplierId: item.supplierId,
        );

        context.read<ItemBloc>().add(UpdateItem(updatedItem));
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            size: 28.sp,
            color: AppColor.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Edit Item",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: item.namaBarang,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: item.deskripsi,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                onChanged: (value) => description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: item.stok.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Stock',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => stock = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: item.harga.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateItem,
                child: Text('Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
