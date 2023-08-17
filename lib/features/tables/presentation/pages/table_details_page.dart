import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/app/app_widgets/loading_indicator/restaurant_loader.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/app/blocs/app_bloc/app_state.dart';
import 'package:restaurant/common/helper/show_message.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';
import 'package:restaurant/features/tables/presentation/pages/choose_item_page.dart';
import 'package:restaurant/features/tables/presentation/widgets/order_item_card.dart';
import 'package:restaurant/models/products_model.dart';
import 'package:restaurant/models/tables_model.dart';

import '../../../../core/utils/responsive_padding.dart';

class TableDetailsPage extends StatefulWidget {
  const TableDetailsPage({Key? key, required this.tableId , this.activeOrder}) : super(key: key);
  final int tableId;
  final ActiveOrder? activeOrder;

  @override
  State<TableDetailsPage> createState() => _TableDetailsPageState();
}

class _TableDetailsPageState extends State<TableDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData( color: Colors.white),
        titleTextStyle:
            textTheme.headline6?.rr.copyWith(color: colorScheme.white),
        centerTitle: true,
        title: const Text('Table Details'),
        backgroundColor: colorScheme.primary,
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context,state){
          if (state.createOrderStatus == CreateOrderStatus.failure) {
            showTopModalSheetErrorMessage(
                context, 'Something went Wrong , please try again');
          }
          if (state.createOrderStatus == CreateOrderStatus.success) {
            showTopModalSheetErrorMessage(context, 'Order Placed Successfully');
          }
        },
        builder: (context, state) {
          if (state.createOrderStatus == CreateOrderStatus.loading) {
            return Center(
              child: RestaurantLoader(),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      10.verticalSpace,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            int productId =
                            state.tablesOrderItems[widget.tableId]![index]
                            ['product_id'];
                            Product product = state.products
                                .firstWhere((element) => element.id == productId);
                            return OrderItemCard(
                              quantity: state.tablesOrderItems[widget.tableId]![index]
                              ['amount'],
                              notes:state.tablesOrderItems[widget.tableId]![index]['notes'],
                              productName: product.name.toString(),
                              saved:false,
                              productId:productId ,
                              tableId: widget.tableId,
                              productNumber: product.number.toString(),
                              productPrice: product.price.toString(),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return Divider(
                              thickness: 3,
                              indent: 8.w,
                              endIndent: 8.w,
                              color: colorScheme.primary,
                            );
                          },
                          itemCount:
                          state.tablesOrderItems[widget.tableId]?.length ?? 0),
                      if(widget.activeOrder!=null)...{
                        if((state.tablesOrderItems[widget.tableId]?.length ?? 0)!=0)
                        Divider(
                          thickness: 3,
                          indent: 8.w,
                          endIndent: 8.w,
                          color: colorScheme.primary,
                        ),
                        if((state.tablesOrderItems[widget.tableId]?.length ?? 0)!=0)
                        10.verticalSpace,
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return OrderItemCard(
                                quantity: widget.activeOrder!.carts![index]
                                    .amount!,
                                notes: widget.activeOrder!.carts![index].notes,
                                productName: widget.activeOrder!.carts![index]
                                    .product!.name.toString(),
                                saved: true,
                                productNumber: widget.activeOrder!.carts![index]
                                    .product!.number.toString(),
                                productPrice: widget.activeOrder!.carts![index]
                                    .product!.price.toString(),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider(
                                thickness: 3,
                                indent: 8.w,
                                endIndent: 8.w,
                                color: colorScheme.primary,
                              );
                            },
                            itemCount: widget.activeOrder!.carts!.length),
                      },
                      100.verticalSpace
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: HWEdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<AppBloc>(context)
                                  .add(CreateOrderEvent(widget.tableId));
                            },
                            child: Container(
                              padding: HWEdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: colorScheme.primary),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.save_alt_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    'Save',
                                    style: textTheme.bodyText1?.rr
                                        .copyWith(color: colorScheme.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ChooseItemPage(tableId: widget.tableId)));
                            },
                            child: Container(
                              padding: HWEdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: colorScheme.primary),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_box_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    'Add Product',
                                    style: textTheme.bodyText1?.rr
                                        .copyWith(color: colorScheme.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
