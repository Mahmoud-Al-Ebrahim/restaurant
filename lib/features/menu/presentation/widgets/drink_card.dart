

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';

import '../../../../app/app_elvated_button.dart';
import '../../../../app/app_widgets/app_text_field.dart';
import '../../../../app/blocs/app_bloc/app_bloc.dart';
import '../../../../app/blocs/app_bloc/app_event.dart';
import '../../../control_panel/helper_functions.dart';
import 'my_cached_network_image.dart';

class DrinkCard extends StatelessWidget {
   DrinkCard(
      {Key? key,
        required this.width,
        required this.radius,
        required this.height,
        required this.name,
        this.addToTable=false,
        required this.imageUrl,
        required this.productId,
        this.tableId,
        required this.number,
        required this.price,
      })
      : super(key: key);
  final double width;
  final double height;
  final String name;
  final String price;
  final String imageUrl;
  final String number;
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
          decoration: BoxDecoration(
            color: context.colorScheme.white,
              borderRadius: BorderRadius.only(topRight:  Radius.circular(radius),topLeft: Radius.circular(radius)),
            border: Border.all(color: context.colorScheme.primary,width: 3)
          ),
          child: Column(
            children: [
              Expanded(child: MyCachedNetworkImage(imageFit: BoxFit.cover,imageUrl: imageUrl,radius: radius,)),
              // Expanded(
              //   child: Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.only(topRight:  Radius.circular(radius),topLeft: Radius.circular(radius)),
              //     image:  DecorationImage(
              //       image: NetworkImage(imageUrl),
              //       fit: BoxFit.cover
              //     )
              //   ),
              //   ),
              // ),
              5.verticalSpace,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('#Number:',
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: context.colorScheme.primary)),
                      5.horizontalSpace,
                      Text(number,
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: Colors.black)),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name:',
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: context.colorScheme.primary)),
                      5.horizontalSpace,
                      Text(name,
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: Colors.black)),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Price:',
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: context.colorScheme.primary)),
                      5.horizontalSpace,
                      Text(price,
                          style:
                          context.textTheme.bodyText1?.rt.copyWith(color: context.colorScheme.black)),
                    ],
                  ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: GestureDetector(
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
                                              color: context.colorScheme.primary,
                                              size: 14.0.sp,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                2.horizontalSpace,
                                SizedBox(
                                  width: 30.w,
                                  height: 30.h,
                                  child: Center(
                                    child: Text(rebuildQuantity.value.toString(),
                                        style: context.textTheme.headline5?.rt
                                            .copyWith(
                                            color: context
                                                .colorScheme.primary)),
                                  ),
                                ),
                                2.horizontalSpace,
                                SizedBox(
                                  width: 0.4.sw,
                                  child: GestureDetector(
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
                                              color: context.colorScheme.primary,
                                              size: 14.0.sp,
                                            )),
                                      ),
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
                              isLoading:false
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




