import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';

import '../../../../core/utils/responsive_padding.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard(
      {Key? key,
      required this.productNumber,
      required this.quantity,
      required this.productName,
      required this.saved,
      this.notes,
      this.tableId,
      this.productId,
      required this.productPrice})
      : super(key: key);
  final String productNumber;
  final int quantity;
  final bool saved;
  final String productName;
  final String productPrice;
  final String? notes;
  final int? tableId;
  final int? productId;
  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 1.sw,
          //height: 200.h,
          margin: HWEdgeInsets.symmetric(horizontal: 8),
          padding: HWEdgeInsets.all(8),
          decoration: BoxDecoration(
              color: colorScheme.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: colorScheme.primary,
                    offset: const Offset(0, 0),
                    blurRadius: 6)
              ]),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('#Number:  ',
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                    Text(widget.productNumber,
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Text('Name:  ',
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                    Text(widget.productName,
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Text('Price:  ',
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                    Text('${widget.productPrice} €',
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                  ],
                ),
                10.verticalSpace,
                if(!widget.saved)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Quantity:  ',
                        style: context.textTheme.headline5?.rt
                            .copyWith(color: context.colorScheme.primary)),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AppBloc>(context).add(ChangeOrderItemQuantityEvent(widget.tableId!, widget.productId!, widget.quantity+1));
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
                           widget.quantity.toString(),
                            style: context.textTheme.headline5?.rt
                                .copyWith(
                                color: context
                                    .colorScheme.primary)),
                      ),
                    ),
                    2.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        if (widget.quantity == 1) {
                          return;
                        }
                        BlocProvider.of<AppBloc>(context).add(ChangeOrderItemQuantityEvent(widget.tableId!, widget.productId!, widget.quantity-1));

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
                )
                else Row(
                children: [
                Text('Quantity:  ',
                style: context.textTheme.headline5?.rt
                    .copyWith(color: context.colorScheme.primary)),
                Text('${widget.quantity}\$',
                style: context.textTheme.headline5?.rt
                    .copyWith(color: context.colorScheme.primary)),
                ],
                ),
                if (widget.notes != null) ...{
                  10.verticalSpace,
                  Row(
                    children: [
                      Text('Notes:  ',
                          style: context.textTheme.headline5?.rt
                              .copyWith(color: context.colorScheme.primary)),
                      Text('${widget.notes}',
                          style: context.textTheme.headline5?.rt
                              .copyWith(color: context.colorScheme.primary)),
                    ],
                  )
                }
              ],
            ),
          ),
        ),
        if (widget.saved)
          Padding(
            padding: HWEdgeInsets.fromLTRB(0,10,25,0),
            child: Icon(
              Icons.check_circle_outline_sharp,
              size: 30,
              color: colorScheme.primaryContainer,
            ),
          )
        else Padding(
          padding: HWEdgeInsets.fromLTRB(0,10,25,0),
          child: InkWell(
            onTap: (){
              BlocProvider.of<AppBloc>(context).add(RemoveOrderItemEvent(widget.tableId!, widget.productId!));
            },
            child: Icon(
              Icons.cancel_outlined,
              size: 30,
              color: colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
