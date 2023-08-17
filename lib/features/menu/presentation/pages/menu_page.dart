import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';

import '../../../../app/app_widgets/app_bottom_navigation_bar.dart';
import '../../../../app/app_widgets/loading_indicator/restaurant_loader.dart';
import '../../../../app/blocs/app_bloc/app_bloc.dart';
import '../../../../app/blocs/app_bloc/app_event.dart';
import '../../../../app/blocs/app_bloc/app_state.dart';
import '../../../../models/products_model.dart';
import 'drinks_page.dart';
import 'meals_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Product> searchedMeals = [];
  List<Product> searchedDrinks = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          titleTextStyle:
              textTheme.headline6?.rr.copyWith(color: colorScheme.white),
          centerTitle: true,
          title: const Text('Menu'),
          backgroundColor: colorScheme.primary,
          bottom: TabBar(
            indicatorColor: colorScheme.primary,
            tabs: [
              Tab(
                child: Text(
                  'Food',
                  style: textTheme.headline6?.rr
                      .copyWith(color: colorScheme.white),
                ),
              ),
              Tab(
                child: Text(
                  'Drinks',
                  style: textTheme.headline6?.rr
                      .copyWith(color: colorScheme.white),
                ),
              )
            ],
          ),
        ),
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.getProductsStatus == GetProductsStatus.loading) {
              return Center(
                child: RestaurantLoader(),
              );
            }
            if (state.getProductsStatus == GetProductsStatus.failure) {
              return Center(
                child: InkWell(
                    onTap: (){
                      BlocProvider.of<AppBloc>(context).add(GetProductsEvent());
                    },
                    child: Icon(Icons.refresh ,color: colorScheme.primary,size: 25,)),
              );
            }
            searchedMeals=[];
            searchedDrinks=[];
            for (Product p in state.products) {
              if (p.type == 'food') {
                searchedMeals.add(p);
              } else {
                searchedDrinks.add(p);
              }
            }
            return TabBarView(
              //physics:const  NeverScrollableScrollPhysics(),
              children: [
                MealsPage(products: searchedMeals),
                DrinksPage(
                  products: searchedDrinks,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
