import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';
import 'app/app_widgets/app_bottom_navigation_bar.dart';
import 'app/blocs/app_bloc/app_bloc.dart';
import 'app/blocs/app_bloc/app_state.dart';
import 'common/helper/show_message.dart';
import 'features/control_panel/presentation/pages/control_page.dart';
import 'features/menu/presentation/pages/menu_page.dart';
import 'features/tables/presentation/pages/tables_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final List<Widget> pages = [
    const MenuPage(),
    const TablesPage(),
    const ControlPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.deleteTableStatus == DeleteTableStatus.success) {
          showTopModalSheetErrorMessage(context, 'Table Deleted Successfully');
        } else if (state.addTableStatus == AddTableStatus.success) {
          showTopModalSheetErrorMessage(context, 'Table Added Successfully');
        } else if (state.editTableStatus == EditTableStatus.success) {
          showTopModalSheetErrorMessage(context, 'Table Edited Successfully');
        } else if (state.deleteProductStatus == DeleteProductStatus.success) {
          showTopModalSheetErrorMessage(
              context, 'Product Deleted Successfully');
        } else if (state.addProductStatus == AddProductStatus.success) {
          showTopModalSheetErrorMessage(
              context, 'Product Added Successfully');
        } else if (state.editProductStatus == EditProductStatus.success) {
          showTopModalSheetErrorMessage(
              context, 'Product Added Successfully');
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        bottomNavigationBar: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return const AppBottomNavBar();
            }),
        body: BlocBuilder<AppBloc, AppState>(
          buildWhen: (oldState, newState) =>
          oldState.currentIndex != newState.currentIndex,
          builder: (_, state) {
            return pages[state.currentIndex];
          },
        ),
      ),
    );
  }
}
