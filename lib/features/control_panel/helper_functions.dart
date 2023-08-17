
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';

Future<void> myAlertDialog(BuildContext context, String title,
    {Widget? alertDialogContent,
      bool? dismissible,
      bool? withCancelButton,
      Color? alertDialogBackColor}) async {
  await showDialog<String>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: dismissible ?? true,
      barrierColor: Colors.white.withOpacity(0),
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: IntrinsicHeight(
          child: AlertDialog(
            backgroundColor: alertDialogBackColor,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (withCancelButton ?? false) ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: context.colorScheme.primary,
                        size: 30.h,
                      ),
                    ):const SizedBox.shrink(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        title,
                        style:context.textTheme.bodyText1?.rd
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0.r))),
            content: alertDialogContent,
          ),
        ),
      ));
}