import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/constants/app_color.dart';
import '../../../../core/models/item.dart';
import '../../category/category_event.dart';
import '../../category/category_state.dart';
import '../item_bloc.dart';
import '../../category/category_bloc.dart';
import '../item_event.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategory());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        namaBarang: _nameController.text,
        deskripsi: _descriptionController.text,
        stok: int.parse(_stockController.text),
        harga: double.parse(_priceController.text),
        kategoriId: _selectedCategoryId ?? 1,
        supplierId: 1,
      );

      context.read<ItemBloc>().add(CreateItem(newItem));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                style: TextStyle(color: AppColor.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                style: TextStyle(color: AppColor.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(
                  labelText: 'Stock',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: AppColor.white),
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
              SizedBox(height: 16.h),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: 16.sp,
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: AppColor.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CategoryLoaded) {
                    return DropdownButtonFormField<int>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: 'Pilih Kategori',
                        labelStyle: TextStyle(
                          color: AppColor.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      dropdownColor: AppColor.secondary,
                      // Background color
                      items: state.categories.map((category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(
                            category.namaKategori,
                            style: TextStyle(color: AppColor.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a category' : null,
                    );
                  } else {
                    return Text('Failed to load categories');
                  }
                },
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: _addItem,
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
