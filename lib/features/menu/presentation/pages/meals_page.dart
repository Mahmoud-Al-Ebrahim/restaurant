import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/features/menu/presentation/widgets/meal_card.dart';

import '../../../../core/utils/responsive_padding.dart';
import '../../../../models/products_model.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({Key? key, this.addToTable = false, required this.products , this.tableId})
      : super(key: key);
  final bool addToTable;
  final List<Product> products;
  final int? tableId;
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: HWEdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          // childAspectRatio: viewType == 'grid' ? ((SizeConfig.screenWidth!>=350)? 7/8:5/7) : 6 / 2,
          childAspectRatio: 7.w / 8.w,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20.w,
          children: List.generate(
            widget.products.length,
            (index) => MealCard(
                name: widget.products[index].name.toString(),
                number: '${widget.products[index].number}',
                price: '${widget.products[index].price} €',
                tableId: widget.tableId,
                productId: widget.products[index].id!,
                addToTable: widget.addToTable,
                radius: 15),
          ) //getProductObjectAsList
          ),
    );
  }
}
