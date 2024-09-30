import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_color.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    super.key,
    required this.title,
    required this.quantity,
    this.icon,
  });

  final String title;
  final int quantity;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 22.sp),
      margin: EdgeInsets.only(
        top: 22.sp,
      ),
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(0.09),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data $title',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          icon ??
              Icon(
                Icons.stop_circle, // Ikon default
                color: AppColor.white,
                size: 28.sp,
              ),
        ],
      ),
    );
  }
}
