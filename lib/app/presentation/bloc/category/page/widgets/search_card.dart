import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_color.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String?) onSearch; // Change to accept String?

  SearchCard({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 12.sp),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8.sp),
              border: Border.all(color: AppColor.white, width: 2.w),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search categories',
                hintStyle: TextStyle(color: AppColor.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppColor.white),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        IconButton(
          onPressed: () {
            String? query =
                searchController.text.isEmpty ? null : searchController.text;
            onSearch(query); // Pass nullable string
          },
          icon: Icon(
            Icons.search,
            size: 22.sp,
            color: AppColor.white,
          ),
        ),
      ],
    );
  }
}
