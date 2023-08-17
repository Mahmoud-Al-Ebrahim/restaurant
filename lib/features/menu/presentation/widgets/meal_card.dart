import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/core/utils/responsive_padding.dart';

import '../../../../app/app_elvated_button.dart';
import '../../../../app/app_widgets/app_text_field.dart';
import '../../../control_panel/helper_functions.dart';

class MealCard extends StatelessWidget {
  MealCard({Key? key,
    required this.radius,
    required this.price,
    this.addToTable = false,
    this.tableId,
    required this.productId,
    required this.number,
    required this.name})
      : super(key: key);
  final String name;
  final String number;
  final String price;
  final double radius;
  final bool addToTable;
  final int? tableId;
  final int productId;
  final ValueNotifier<int> rebuildQuantity = ValueNotifier(1);
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: HWEdgeInsets.symmetric(vertical: 60),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff007CFF).withOpacity(0.16),
                    offset: const Offset(0, 3),
                    blurRadius: 6)
              ],
              color: context.colorScheme.borderTextField,
              border: Border.all(color: const Color(0xff80baff), width: 3),
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                colors: [
                  //Color(0xffacffe9),
                  context.colorScheme.primary,
                  const Color(0xff80baff),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('#Number:',
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: context.colorScheme.white)),
                  5.horizontalSpace,
                  Text(number,
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: Colors.white)),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name:',
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: context.colorScheme.white)),
                  5.horizontalSpace,
                  Text(name,
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: Colors.white)),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Price:',
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: context.colorScheme.white)),
                  5.horizontalSpace,
                  Text(price,
                      style: context.textTheme.bodyText1?.rt
                          .copyWith(color: context.colorScheme.white)),
                ],
              ),
            ],
          ),
        ),
        if (addToTable) ...{
          InkWell(
            onTap: () {
              myAlertDialog(context, 'Confirm Adding',
                  withCancelButton: true,
                  dismissible: false,
                  alertDialogContent: ValueListenableBuilder<int>(
                      valueListenable: rebuildQuantity,
                      builder: (context, rebuild, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Quantity:',
                                style: context.textTheme.headline5?.rt.copyWith(
                                    color: context.colorScheme.primary)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    rebuildQuantity.value++;
                                  },
                                  child: CircleAvatar(
                                    radius: 12.sp,
                                    backgroundColor:
                                    context.colorScheme.primary,
                                    child: CircleAvatar(
                                      radius: 11.sp,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: context.colorScheme
                                                .primary,
                                            size: 14.0.sp,
                                          )),
                                    ),
                                  ),
                                ),
                                2.horizontalSpace,
                                SizedBox(
                                  width: 30.w,
                                  height: 30.h,
                                  child: Center(
                                    child: Text(
                                        rebuildQuantity.value.toString(),
                                        style: context.textTheme.headline5?.rt
                                            .copyWith(
                                            color: context
                                                .colorScheme.primary)),
                                  ),
                                ),
                                2.horizontalSpace,
                                GestureDetector(
                                  onTap: () {
                                    if (rebuildQuantity.value == 1) {
                                      return;
                                    }
                                    rebuildQuantity.value--;
                                  },
                                  child: CircleAvatar(
                                    radius: 12.sp,
                                    backgroundColor:
                                    context.colorScheme.primary,
                                    child: CircleAvatar(
                                      radius: 11.sp,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: context.colorScheme
                                                .primary,
                                            size: 14.0.sp,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            AppTextField(
                              hintText: 'Add Notes',
                              controller: notesController,
                            ),
                            10.verticalSpace,
                            AppElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AppBloc>(context).add(AddOrderItemEvent(tableId!, productId, rebuildQuantity.value, notesController.text));
                                  rebuildQuantity.value=1;
                                  notesController.text='';
                                  Navigator.pop(context);
                                },
                                text: 'Confirm',
                                isLoading: false
                            )
                          ],
                        );
                      }));
            },
            child: Transform.translate(
              offset: const Offset(-5,5),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child:
                Icon(Icons.add, size: 25, color: context.colorScheme.primary),
              ),
            ),
          )
        }
      ],
    );
  }
}
