import 'package:flutter/material.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/models/tables_model.dart';

import '../pages/table_details_page.dart';

class TableCard extends StatelessWidget {
  const TableCard(
      {Key? key,
      required this.width,
      required this.radius,
        this.activeOrder,
      required this.height,
      required this.tableId,
      required this.isActive,
      required this.text})
      : super(key: key);
  final double width;
  final double height;
  final String text;
  final double radius;
  final bool isActive;
  final int tableId;
  final ActiveOrder? activeOrder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  TableDetailsPage(tableId: tableId,activeOrder: activeOrder,)));
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF4AA045).withOpacity(0.16),
                  offset: const Offset(0, 3),
                  blurRadius: 6)
            ],
            border: isActive ? Border.all(color: const Color(0xFF4AA045),width: 3) :  null ,
            color: !isActive ? context.colorScheme.borderTextField : null,
            borderRadius: BorderRadius.circular(radius),
            gradient: isActive ?  LinearGradient(
              colors: [
               // Color(0xffacffe9),
               //  Color(0xFF4AA045),
               //  Color(0xff80baff),
                context.colorScheme.primary,
                const Color(0xff80baff),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ): null),
        child: Center(
          child: Text(text,
              style:
                  context.textTheme.bodyText1?.rt.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
