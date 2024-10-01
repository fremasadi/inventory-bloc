import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/app/presentation/bloc/item/page/item_page.dart';
import 'package:inventory/app/presentation/bloc/supplier/page/supplier_page.dart';
import 'package:inventory/app/presentation/constants/app_color.dart';
import 'package:inventory/app/presentation/bloc/category/page/category_page.dart';
import 'package:inventory/app/presentation/bloc/category/page/widgets/horizontal_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'bloc/category/category_bloc.dart';
import 'bloc/category/category_state.dart';
import 'bloc/item/item_bloc.dart';
import 'bloc/item/item_state.dart';
import 'bloc/supplier/supplier_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<_TransactionData> data = [
    _TransactionData('Minggu 1', 50, 30),
    _TransactionData('Minggu 2', 70, 40),
    _TransactionData('Minggu 3', 60, 50),
    _TransactionData('Minggu 4', 90, 70),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          Icons.inventory,
          size: 32.sp,
          color: AppColor.yellow,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // Ensure it doesn't take full height
                      children: [
                        ListTile(
                          leading: Icon(Icons.category, color: AppColor.white),
                          title: Text('Categories',
                              style: TextStyle(color: AppColor.white)),
                          onTap: () {
                            Navigator.pop(context); // Close the modal
                            // Navigate to Categories Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.circle, color: AppColor.white),
                          title: Text('Item',
                              style: TextStyle(color: AppColor.white)),
                          onTap: () {
                            Navigator.pop(context); // Close the modal
                            // Navigate to Categories Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.man, color: AppColor.white),
                          title: Text('Supplier',
                              style: TextStyle(color: AppColor.white)),
                          onTap: () {
                            Navigator.pop(context); // Close the modal
                            // Navigate to Categories Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupplierPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.list,
              size: 28.sp,
              color: AppColor.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.sp, horizontal: 26.sp),
                    decoration: BoxDecoration(
                      color: AppColor.blueLight,
                      borderRadius: BorderRadius.circular(16.sp),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: AppColor.white,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 22.sp),
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(
                    axisLine: AxisLine(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                  ),
                  title: ChartTitle(text: 'Transaksi Barang Masuk dan Keluar'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    LineSeries<_TransactionData, String>(
                      name: 'Barang Masuk',
                      dataSource: data,
                      xValueMapper: (_TransactionData data, _) => data.month,
                      yValueMapper: (_TransactionData data, _) =>
                          data.barangMasuk,
                      markerSettings: MarkerSettings(isVisible: true),
                      color: Colors.teal,
                    ),
                    LineSeries<_TransactionData, String>(
                      name: 'Barang Keluar',
                      dataSource: data,
                      xValueMapper: (_TransactionData data, _) => data.month,
                      yValueMapper: (_TransactionData data, _) =>
                          data.barangKeluar,
                      markerSettings: MarkerSettings(isVisible: true),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CategoryLoaded) {
                    return HorizontalCard(
                      title: 'Kategori',
                      quantity: state.categories.length,
                    );
                  } else {
                    return Text(
                      'Failed to load categories',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    );
                  }
                },
              ),

              // Bloc untuk Item
              BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  if (state is ItemLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ItemLoaded) {
                    return HorizontalCard(
                      title: 'Barang',
                      quantity: state.items.length,
                    );
                  } else {
                    return Text('Failed to load items');
                  }
                },
              ),
              BlocBuilder<SupplierBloc, SupplierState>(
                builder: (context, state) {
                  if (state is SupplierLoading) {
                    return CircularProgressIndicator();
                  } else if (state is SupplierLoaded) {
                    return HorizontalCard(
                      title: 'Supplier',
                      quantity: state.suppliers.length,
                    );
                  } else {
                    return Text('Failed to load suppliers');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionData {
  _TransactionData(this.month, this.barangMasuk, this.barangKeluar);

  final String month;
  final int barangMasuk;
  final int barangKeluar;
}
