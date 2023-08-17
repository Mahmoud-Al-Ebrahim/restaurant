import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/app/blocs/app_bloc/app_state.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';

import '../../../../app/app_widgets/loading_indicator/restaurant_loader.dart';
import '../../../../app/blocs/app_bloc/app_bloc.dart';
import '../../../../core/utils/responsive_padding.dart';
import '../widgets/table_card.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key? key}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.white,
      appBar: AppBar(
        titleTextStyle: textTheme.headline6?.rr.copyWith(
            color: colorScheme.white),
        centerTitle: true,
        title: const Text('Tables'),
        backgroundColor: colorScheme.primary,
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.getTablesStatus == GetTablesStatus.loading) {
            return Center(
              child: RestaurantLoader(),
            );
          }
          if (state.getProductsStatus == GetProductsStatus.failure) {
            return Center(
              child: InkWell(
                  onTap: (){
                    BlocProvider.of<AppBloc>(context).add(GetTablesEvent());
                  },
                  child: Icon(Icons.refresh ,color: colorScheme.primary,size: 25,)),
            );
          }
          return SafeArea(
            child: Padding(
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
                  mainAxisSpacing: 20.h,
                  children: List.generate(
                    state.tables.length,
                        (index) =>
                        TableCard(
                            text: 'Number: #${state.tables[index].number.toString()}',
                            tableId: state.tables[index].id!,
                            width: 0.4.sw,
                            activeOrder: state.tables[index].activeOrder ,
                            isActive: state.tables[index].activeOrder != null || (state.tablesOrderItems[state.tables[index].id!]?.length ?? 0)!=0,
                            height: 0.2.sh,
                            radius: 15),
                  ) //getProductObjectAsList
              ),
            ),
          );
        },
      ),
    );
  }
}
