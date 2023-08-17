import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/app/app_elvated_button.dart';
import 'package:restaurant/app/app_widgets/app_text_field.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/common/helper/show_message.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';
import 'package:restaurant/features/control_panel/helper_functions.dart';
import 'package:restaurant/features/control_panel/presentation/widgets/control_item.dart';
import 'package:restaurant/features/control_panel/presentation/widgets/restaurant_drop_down.dart';
import 'package:restaurant/models/products_model.dart';
import '../../../../models/tables_model.dart' as tm;
import '../../../../app/blocs/app_bloc/app_state.dart';
import '../../../../core/utils/responsive_padding.dart';
import '../../bloc/fetch_image/fetch_image_cubit.dart';
import '../../bloc/fetch_image/fetch_image_state.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late AppBloc appBloc;
  TextEditingController tableNumberController = TextEditingController();
  TextEditingController tableNewNumberController = TextEditingController();

  TextEditingController productNumberController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productNewNumberController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productController = TextEditingController();
  String productType = 'food';
  String imageNameForEdit = '';
  final ValueNotifier<bool> displayTakePicture = ValueNotifier(false);
  final ValueNotifier<bool> rebuildTypes = ValueNotifier(false);

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  cleanUi() {
    tableNumberController.text = '';
    tableNewNumberController.text = '';
    productNumberController.text = '';
    productPriceController.text = '';
    productNewNumberController.text = '';
    productNameController.text = '';
    productController.text = '';
    productType = 'food';
    context.read<FetchImageCubit>().removeImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.white,
      appBar: AppBar(
        titleTextStyle:
            textTheme.headline6?.rr.copyWith(color: colorScheme.white),
        centerTitle: true,
        title: const Text('Control'),
        backgroundColor: colorScheme.primary,
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state.deleteTableStatus == DeleteTableStatus.success ||
              state.editProductStatus == EditProductStatus.success ||
              state.addProductStatus == AddProductStatus.success ||
              state.deleteProductStatus == DeleteProductStatus.success ||
              state.editTableStatus == EditTableStatus.success ||
              state.addTableStatus == AddTableStatus.success) {
            cleanUi();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: HWEdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  20.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        myAlertDialog(context, 'Delete Table',
                            withCancelButton: true,
                            dismissible: false,
                            alertDialogContent: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextField(
                                  hintText: 'Enter table number',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: tableNumberController,
                                ),
                                15.verticalSpace,
                                AppElevatedButton(
                                  onPressed: () {
                                    if (tableNumberController.text.isEmpty) {
                                      showTopModalSheetErrorMessage(
                                          context, 'Please Enter Table Number');
                                      return;
                                    }
                                    String id = state.tables
                                        .firstWhere(
                                            (element) =>
                                                element.number ==
                                                tableNumberController.text,
                                            orElse: () => tm.Table(id: -1))
                                        .id
                                        .toString();
                                    if (id == '-1') {
                                      showTopModalSheetErrorMessage(context,
                                          'There is no table with this number');
                                      return;
                                    }
                                    tableNumberController.text = '';
                                    appBloc.add(DeleteTableEvent(id));
                                    cleanUi();
                                  },
                                  text: 'Delete',
                                  isLoading: state.deleteTableStatus ==
                                      DeleteTableStatus.loading,
                                )
                              ],
                            ));
                      },
                      icon: Icons.delete,
                      title: 'Delete Table'),
                  15.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        myAlertDialog(context, 'Add Table',
                            withCancelButton: true, dismissible: false,
                            alertDialogContent: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextField(
                                  hintText: 'Enter table number',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: tableNumberController,
                                ),
                                15.verticalSpace,
                                AppElevatedButton(
                                  onPressed: () {
                                    if (tableNumberController.text.isEmpty) {
                                      showTopModalSheetErrorMessage(
                                          context, 'Please Enter Table Number');
                                      return;
                                    }
                                    String id = state.tables
                                        .firstWhere(
                                            (element) =>
                                                element.number ==
                                                tableNumberController.text,
                                            orElse: () => tm.Table(id: -1))
                                        .id
                                        .toString();
                                    if (id != '-1') {
                                      showTopModalSheetErrorMessage(
                                          context, 'This number already used');
                                      return;
                                    }
                                    appBloc.add(AddTableEvent(
                                        tableNumberController.text));
                                  },
                                  text: 'Add',
                                  isLoading: state.addTableStatus ==
                                      AddTableStatus.loading,
                                )
                              ],
                            );
                          },
                        ));
                      },
                      icon: Icons.add,
                      title: 'Add Table'),
                  15.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        myAlertDialog(context, 'Edit Table',
                            withCancelButton: true, dismissible: false,
                            alertDialogContent: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextField(
                                  hintText: 'Enter Previous table number',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: tableNumberController,
                                ),
                                10.verticalSpace,
                                AppTextField(
                                  hintText: 'Enter New table number',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: tableNewNumberController,
                                ),
                                15.verticalSpace,
                                AppElevatedButton(
                                  onPressed: () {
                                    if (tableNumberController.text.isEmpty ||
                                        tableNewNumberController.text.isEmpty) {
                                      showTopModalSheetErrorMessage(context,
                                          'Please Enter Previous and New Table Number');
                                      return;
                                    }
                                    String id = state.tables
                                        .firstWhere(
                                            (element) =>
                                                element.number ==
                                                tableNumberController.text,
                                            orElse: () => tm.Table(id: -1))
                                        .id
                                        .toString();
                                    if (id == '-1') {
                                      showTopModalSheetErrorMessage(context,
                                          'there is no Table with that previous number');
                                      return;
                                    }
                                    String id2 = state.tables
                                        .firstWhere(
                                            (element) =>
                                                element.number ==
                                                tableNewNumberController.text,
                                            orElse: () => tm.Table(id: -1))
                                        .id
                                        .toString();
                                    if (id2 != '-1') {
                                      showTopModalSheetErrorMessage(context,
                                          'This new Number already used');
                                      return;
                                    }
                                    appBloc.add(EditTableEvent(
                                        id, tableNewNumberController.text));
                                  },
                                  text: 'Edit',
                                  isLoading: state.editTableStatus ==
                                      EditTableStatus.loading,
                                )
                              ],
                            );
                          },
                        ));
                      },
                      icon: Icons.edit,
                      title: 'Edit Table'),
                  15.verticalSpace,
                  Divider(
                    thickness: 8,
                    color: Colors.grey.shade200,
                  ),
                  15.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        myAlertDialog(context, 'Delete Item',
                            withCancelButton: true, dismissible: false,
                            alertDialogContent: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextField(
                                  hintText: 'Enter item number',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: productNumberController,
                                ),
                                15.verticalSpace,
                                AppElevatedButton(
                                  onPressed: () {
                                    if (productNumberController.text.isEmpty) {
                                      showTopModalSheetErrorMessage(
                                          context, 'Please Enter Item Number');
                                      return;
                                    }
                                    String id = state.products
                                        .firstWhere(
                                            (element) =>
                                                element.number ==
                                                productNumberController.text,
                                            orElse: () =>
                                                Product(id: -1, type: ''))
                                        .id
                                        .toString();
                                    if (id == '-1') {
                                      showTopModalSheetErrorMessage(context,
                                          'There is no product with this number');
                                      return;
                                    }
                                    productNumberController.text = '';
                                    appBloc.add(DeleteProductEvent(id));
                                  },
                                  text: 'Delete',
                                  isLoading: state.deleteProductStatus ==
                                      DeleteProductStatus.loading,
                                )
                              ],
                            );
                          },
                        ));
                      },
                      icon: Icons.delete,
                      title: 'Delete Item'),
                  15.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        myAlertDialog(context, 'Add Item',
                            withCancelButton: true, dismissible: false,
                            alertDialogContent: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextField(
                                    hintText: 'Enter Item number',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: productNumberController,
                                  ),
                                  10.verticalSpace,
                                  AppTextField(
                                    hintText: 'Enter Item Name',
                                    controller: productNameController,
                                  ),
                                  10.verticalSpace,
                                  AppTextField(
                                    hintText: 'Enter Item Price',
                                    controller: productPriceController,
                                  ),
                                  10.verticalSpace,
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('select item type:',
                                            style:
                                                context.textTheme.bodyText2?.br),
                                        5.verticalSpace,
                                        RestaurantDropDownMenu<String>(
                                          onChange: (selected) {
                                            productType = selected;
                                            if (productType == 'drink') {
                                              displayTakePicture.value = true;
                                            } else {
                                              displayTakePicture.value = false;
                                            }
                                          },
                                          value: 'food',
                                          hint: 'select item type',
                                          items: const ['food', 'drink'],
                                        ),
                                      ]),
                                  10.verticalSpace,
                                  ValueListenableBuilder<bool>(
                                      valueListenable: displayTakePicture,
                                      builder: (context, display, _) {
                                        return display
                                            ? Column(
                                                children: [
                                                  AppElevatedButton(
                                                    text: 'take picture',
                                                    onPressed: () async {
                                                      context
                                                          .read<FetchImageCubit>()
                                                          .fetchImage();
                                                    },
                                                  ),
                                                  5.verticalSpace,
                                                  BlocBuilder<FetchImageCubit,
                                                          FetchImageState>(
                                                      builder: (context, state) {
                                                    if (state is FetchImageDone) {
                                                      String fileName = state
                                                          .imageUrl.path
                                                          .split('/')
                                                          .last;
                                                      return Text(
                                                        fileName,
                                                        style: context.textTheme
                                                            .bodyText1?.rr,
                                                      );
                                                    }
                                                    return const SizedBox
                                                        .shrink();
                                                  }),
                                                  10.verticalSpace,
                                                ],
                                              )
                                            : const SizedBox.shrink();
                                      }),
                                  AppElevatedButton(
                                    onPressed: () {
                                      if (productNumberController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter product Number');
                                        return;
                                      }
                                      if (productNameController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Enter product name');
                                        return;
                                      }
                                      if (productPriceController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter product price');
                                        return;
                                      }
                                      if (double.tryParse(
                                              productPriceController.text) ==
                                          null) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter a valid price');
                                        return;
                                      }
                                      if (productType.isEmpty) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Enter product type');
                                        return;
                                      }
                                      if (productType == 'drink' &&
                                          context
                                                  .read<FetchImageCubit>()
                                                  .getFile ==
                                              null) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Add a Picture');
                                        return;
                                      }
                                      String id = state.products
                                          .firstWhere(
                                              (element) =>
                                                  element.number ==
                                                  productNumberController.text,
                                              orElse: () =>
                                                  Product(id: -1, type: ''))
                                          .id
                                          .toString();
                                      if (id != '-1') {
                                        showTopModalSheetErrorMessage(context,
                                            'This product number already used');
                                        return;
                                      }
                                      final File? file = productType == 'drink'
                                          ? File(context
                                              .read<FetchImageCubit>()
                                              .getFile!
                                              .path)
                                          : null;
                                      appBloc.add(AddProductEvent(
                                          productNumberController.text,
                                          productNameController.text,
                                          productType,
                                          file,
                                          productPriceController.text));
                                    },
                                    text: 'Add',
                                    isLoading: state.addProductStatus ==
                                        AddProductStatus.loading,
                                  )
                                ],
                              ),
                            );
                          },
                        ));
                      },
                      icon: Icons.add,
                      title: 'Add Item'),
                  15.verticalSpace,
                  ControlItem(
                      onPressed: () {
                        productNumberController.addListener(() {
                          if (productNumberController.text.isNotEmpty) {
                            Product p = state.products.firstWhere(
                                (element) =>
                                    element.number.toString() ==
                                    productNumberController.text,
                                orElse: () => Product(type: 'food'));
                            productType = p.type;
                            productNameController.text = p.name ?? '';
                            productPriceController.text = p.price ?? '';
                            if(productType=='drink') {
                              displayTakePicture.value = true;
                              imageNameForEdit = p.photoPath!.split('/').last;
                            }
                            setState(() {});
                            rebuildTypes.value=!rebuildTypes.value;
                          }
                        });
                        myAlertDialog(context, 'Edit Item',
                            withCancelButton: true, dismissible: false,
                            alertDialogContent: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextField(
                                    hintText: 'Enter Previous Item number',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: productNumberController,
                                  ),
                                  10.verticalSpace,
                                  AppTextField(
                                    hintText: 'Enter New Item number',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: productNewNumberController,
                                  ),
                                  10.verticalSpace,
                                  AppTextField(
                                    hintText: 'Enter New Item Name',
                                    controller: productNameController,
                                  ),
                                  10.verticalSpace,
                                  AppTextField(
                                    hintText: 'Enter New Item Price',
                                    controller: productPriceController,
                                  ),
                                  10.verticalSpace,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('select item type:',
                                          style: context.textTheme.bodyText2?.br),
                                      5.verticalSpace,
                                      ValueListenableBuilder<bool>(
                                          valueListenable: rebuildTypes,
                                          builder: (context, rebuild, _) {
                                            return RestaurantDropDownMenu<String>(
                                              onChange: (selected) {
                                                productType = selected;
                                                if (productType == 'drink') {
                                                  displayTakePicture.value = true;
                                                } else {
                                                  displayTakePicture.value = false;
                                                }
                                              },
                                              value: productType,
                                              hint: 'select item type',
                                              items: const ['food', 'drink'],
                                            );
                                          }),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  ValueListenableBuilder<bool>(
                                      valueListenable: displayTakePicture,
                                      builder: (context, display, _) {
                                        return display
                                            ? Column(
                                                children: [
                                                  AppElevatedButton(
                                                    text: 'take picture',
                                                    onPressed: () async {
                                                      context
                                                          .read<FetchImageCubit>()
                                                          .fetchImage();
                                                      imageNameForEdit = '';
                                                     rebuildTypes.value=!rebuildTypes.value;
                                                    },
                                                  ),
                                                  5.verticalSpace,
                                                  BlocBuilder<FetchImageCubit,
                                                          FetchImageState>(
                                                      builder: (context, state) {
                                                    if (state is FetchImageDone) {
                                                      String fileName = state
                                                          .imageUrl.path
                                                          .split('/')
                                                          .last;
                                                      return Text(
                                                        fileName,
                                                        style: context.textTheme
                                                            .bodyText1?.rr,
                                                      );
                                                    }
                                                    return const SizedBox
                                                        .shrink();
                                                  }),
                                                  10.verticalSpace,
                                                ],
                                              )
                                            : const SizedBox.shrink();
                                      }),
                                  ValueListenableBuilder<bool>(valueListenable: rebuildTypes, builder: (ctx,rebuild,_){
                                    return imageNameForEdit != '' ? Column(
                                      children: [
                                        5.verticalSpace,
                                        Text(
                                          imageNameForEdit,
                                          style: context.textTheme.bodyText1?.rr,
                                        ),
                                      ],
                                    ):const SizedBox.shrink();
                                  }),
                                  AppElevatedButton(
                                    onPressed: () {
                                      if (productNumberController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter Previous product Number');
                                        return;
                                      }
                                      if (productNumberController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter product Number');
                                        return;
                                      }
                                      if (productNameController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Enter product name');
                                        return;
                                      }
                                      if (productPriceController.text.isEmpty) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter product price');
                                        return;
                                      }
                                      if (double.tryParse(
                                              productPriceController.text) ==
                                          null) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter a valid price');
                                        return;
                                      }
                                      if (productType.isEmpty) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Enter product type');
                                        return;
                                      }
                                      if (productType == 'drink' &&
                                          context
                                                  .read<FetchImageCubit>()
                                                  .getFile ==
                                              null) {
                                        showTopModalSheetErrorMessage(
                                            context, 'Please Add a Picture');
                                        return;
                                      }
                                      int id = state.products
                                          .firstWhere(
                                              (element) =>
                                                  element.number ==
                                                  productNumberController.text,
                                              orElse: () =>
                                                  Product(id: -1, type: ''))
                                          .id!;
                                      if (id == -1) {
                                        showTopModalSheetErrorMessage(context,
                                            'There is no product with this previous number');
                                        return;
                                      }
                                      String id2 = state.products
                                          .firstWhere(
                                              (element) =>
                                                  element.number ==
                                                  productNewNumberController.text,
                                              orElse: () =>
                                                  Product(id: -1, type: ''))
                                          .id
                                          .toString();
                                      if (id2 != '-1') {
                                        showTopModalSheetErrorMessage(context,
                                            'This new product number already used');
                                        return;
                                      }
                                      if (productPriceController
                                              .text.isNotEmpty &&
                                          double.tryParse(
                                                  productPriceController.text) ==
                                              null) {
                                        showTopModalSheetErrorMessage(context,
                                            'Please Enter a valid price');
                                        return;
                                      }
                                      final File? file = context
                                                  .read<FetchImageCubit>()
                                                  .getFile !=
                                              null
                                          ? File(context
                                              .read<FetchImageCubit>()
                                              .getFile!
                                              .path)
                                          : null;
                                      appBloc.add(EditProductEvent(
                                          id.toString(),
                                          productNewNumberController.text.isEmpty ? productNumberController.text : productNewNumberController.text,
                                          productNameController.text,
                                          productType,
                                          file,
                                          productPriceController.text,imageNameForEdit=='' ? null : imageNameForEdit));
                                    },
                                    text: 'Edit',
                                    isLoading: state.editProductStatus ==
                                        EditProductStatus.loading,
                                  )
                                ],
                              ),
                            );
                          },
                        ));
                      },
                      icon: Icons.edit,
                      title: 'Edit Item'),
                  15.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
