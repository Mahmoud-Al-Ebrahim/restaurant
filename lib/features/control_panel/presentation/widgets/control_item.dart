
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';

class ControlItem extends StatelessWidget {
  const ControlItem({Key? key , required this.onPressed, required this.icon, required this.title}) : super(key: key);
  final void Function() onPressed;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 65.h,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(2.0.sp),
          border: Border.all(width: 1.0, color: context.colorScheme.primary),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30.w,
            ),
            SizedBox(
                width: 28.w,
                child: Icon(
                  icon,
                  color: context.colorScheme.primary,
                  size: 20.h,
                )
            ),
            SizedBox(
              width: 26.w,
            ),
            Text(
              title,
              style: context.textTheme.headline5?.rr.copyWith(
                  color: context.colorScheme.primary
              ),
            ),
          ],
        ),
      ),
    );
  }
}