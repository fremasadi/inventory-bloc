import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/core/repository/category_repository.dart';
import 'app/core/repository/item_repository.dart';
import 'app/core/repository/supplier_repository.dart';
import 'app/presentation/bloc/category/category_bloc.dart';
import 'app/presentation/bloc/item/item_bloc.dart';
import 'app/presentation/bloc/supplier/supplier_bloc.dart';
import 'app/presentation/constants/app_color.dart';
import 'app/presentation/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  CategoryBloc(CategoryRepository())..add(FetchCategory()),
            ),
            BlocProvider(
              create: (context) => ItemBloc(ItemRepository())..add(FetchItem()),
            ),
            BlocProvider(
              create: (context) =>
                  SupplierBloc(SupplierRepository())..add(FetchSupplier()),
            ),
          ],
          child: MaterialApp(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                  data: data.copyWith(
                    textScaler: const TextScaler.linear(1.10),
                  ),
                  child: child!);
            },
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.primary,
              appBarTheme: AppBarTheme(
                backgroundColor: AppColor.primary,
              ),
            ),
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
