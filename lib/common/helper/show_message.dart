import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../app/app_elvated_button.dart';

showTopModalSheetErrorMessage(BuildContext context, String message) {
  showTopModalSheet<String>(
    context,
    Builder(builder: (context) {
      return IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          color: Colors.white.withOpacity(0.8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top / 2 + 5.h,
              ),
              Expanded(
                child: Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyText1?.rr,
                  maxLines: 10,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: AppElevatedButton(
                    text: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      );
    }),
  );
}
