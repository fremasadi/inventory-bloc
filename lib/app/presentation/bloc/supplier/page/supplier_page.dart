import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/bloc/supplier/page/widgets/add_supplier_button.dart';

import '../../../../core/models/supplier.dart';
import '../../../constants/app_color.dart';
import '../supplier_bloc.dart';

class SupplierPage extends StatelessWidget {
  SupplierPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddSupplierButton(
          nameController: nameController, contactController: contactController),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .1),
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
              child: BlocBuilder<SupplierBloc, SupplierState>(
                builder: (context, state) {
                  if (state is SupplierLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SupplierLoaded) {
                    return _buildSupplierList(state.suppliers);
                  } else if (state is SupplierError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Tidak ada supplier'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierList(List<Supplier> suppliers) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: suppliers.length,
      itemBuilder: (context, index) {
        final supplier = suppliers[index];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
          margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          decoration: BoxDecoration(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supplier.namaSupplier,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    supplier.kontakSupplier,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.white,
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 22.sp,
                  color: AppColor.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
