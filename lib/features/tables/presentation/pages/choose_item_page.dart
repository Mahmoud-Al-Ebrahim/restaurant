import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/app/app_widgets/loading_indicator/restaurant_loader.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_state.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';
import 'package:restaurant/core/utils/responsive_padding.dart';
import 'package:restaurant/models/products_model.dart';

import '../../../../app/app_widgets/app_text_field.dart';
import '../../../menu/presentation/pages/drinks_page.dart';
import '../../../menu/presentation/pages/meals_page.dart';

class ChooseItemPage extends StatefulWidget {
  const ChooseItemPage({Key? key , required this.tableId}) : super(key: key);

  final int tableId;

  @override
  State<ChooseItemPage> createState() => _ChooseItemPageState();
}

class _ChooseItemPageState extends State<ChooseItemPage> {

  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> rebuildMealsAndDrinks=ValueNotifier(false);
   String? searchText;
  List<Product> initialProducts=[];
  List<Product> searchedMeals=[];
  List<Product> searchedDrinks=[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
  builder: (context, state) {
    if(state.getProductsStatus==GetProductsStatus.loading){
      return Center(
        child: RestaurantLoader(),
      );
    }
    initialProducts=state.products;
    searchedMeals=[];
    searchedDrinks=[];
   for(Product p in initialProducts){
     if(p.type=='food'){
       searchedMeals.add(p);
     }else{
       searchedDrinks.add(p);
     }
   }
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child:Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          titleTextStyle: textTheme.headline6?.rr.copyWith(color: colorScheme.white),
          iconTheme: const IconThemeData( color: Colors.white),
          centerTitle: true,
          title: Container(
            margin: HWEdgeInsets.symmetric(horizontal: 10,vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(22))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(22)),
              child: AppTextField(
                hintText: 'search',
                onChange: (String? text){
                  if(text?.isEmpty ?? true){
                    text='';
                  }
                  searchedMeals=[];
                  searchedDrinks=[];
                  for(Product p in initialProducts){
                    if((p.number==text || p.name!.toLowerCase().contains(text!.toLowerCase()))&& p.type=='food'){
                      searchedMeals.add(p);
                    }else if((p.number==text || p.name!.toLowerCase().contains(text!.toLowerCase()))){
                      searchedDrinks.add(p);
                    }
                  }
                  rebuildMealsAndDrinks.value=!rebuildMealsAndDrinks.value;
                },
                prefixIcon: const Icon(Icons.search , color: Colors.grey ,size: 20),
                controller: searchController,
              ),
            ),
          ),
          backgroundColor: colorScheme.primary,
          bottom:  TabBar(
            indicatorColor: colorScheme.primary,
            tabs:  [
              Tab(
                child:
                Text('Food', style: textTheme.headline6?.rr.copyWith(color: colorScheme.white),),
              ),
              Tab(
                child:
                Text('Drinks', style: textTheme.headline6?.rr.copyWith(color: colorScheme.white),),)
            ],
          ),
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: rebuildMealsAndDrinks,
          builder: (context,rebuild,_) {
            return  TabBarView(
             // physics: const NeverScrollableScrollPhysics(),
              children: [
                MealsPage(addToTable: true,products: searchedMeals,tableId: widget.tableId),
                DrinksPage(addToTable: true ,products: searchedDrinks,tableId : widget.tableId )
              ],
            );
          }
        ),),
    );
  },
);
  }
}
