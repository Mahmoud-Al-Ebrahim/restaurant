
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/common/constant/configuration/url_routes.dart';
import '../../../../core/utils/responsive_padding.dart';
import '../../../../models/products_model.dart';
import '../widgets/drink_card.dart';

class DrinksPage extends StatefulWidget {
  const DrinksPage({Key? key , this.addToTable=false,required this.products,this.tableId}) : super(key: key);
  final bool addToTable;
  final List<Product> products;
  final int? tableId;

  @override
  State<DrinksPage> createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: HWEdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
      child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          // childAspectRatio: viewType == 'grid' ? ((SizeConfig.screenWidth!>=350)? 7/8:5/7) : 6 / 2,
          childAspectRatio: 9.w / 15.w,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 20.w,
          children: List.generate(
            widget.products.length,
                (index) => DrinkCard(
                name: widget.products[index].name.toString(),
                number: '${widget.products[index].number}',
                imageUrl: 'http://44.202.51.221/orderingSystem/public${widget.products[index].photoPath.toString()}',
                price: '${widget.products[index].price} €',
                    productId: widget.products[index].id!,
                    addToTable:widget.addToTable,
                    tableId: widget.tableId,
                    width: 0.4.sw,
                height: 0.2.sh,
                radius: 15
                ),
          ) //getProductObjectAsList
      ),
    );
  }
}
