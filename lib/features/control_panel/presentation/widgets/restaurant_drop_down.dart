import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/core/utils/extensions/state_ext.dart';

class RestaurantDropDownMenu<T> extends StatefulWidget {
  const RestaurantDropDownMenu({
    this.items,
    this.onChange,
    this.onSaved,
    this.onTap,
    this.validator,
    this.hint,
    this.menuMaxHeight,
    this.icon,
    this.focusNode,
    Key? key,
    this.value,
  }) : super(key: key);

  final ValueChanged? onChange;
  final FormFieldSetter? onSaved;
  final FormFieldValidator? validator;
  final VoidCallback? onTap;
  final List<T>? items;
  final String? hint;
  final double? menuMaxHeight;
  final Widget? icon;
  final FocusNode? focusNode;
  final T? value;

  @override
  State<RestaurantDropDownMenu> createState() => _RestaurantDropDownMenuState();
}

class _RestaurantDropDownMenuState<T> extends State<RestaurantDropDownMenu> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      items: widget.items
          ?.map((e) => DropdownMenuItem<T>(
        value: e,
        child: Text(
            e , style: context.textTheme.bodyText1?.rd.copyWith(
          fontWeight: FontWeight.w400
        )),
      ))
          .toList(),
      onChanged: widget.onChange,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      validator: widget.validator,
      menuMaxHeight: widget.menuMaxHeight,
      icon: widget.icon ?? const SizedBox.shrink(),
      focusNode: widget.focusNode,
      value: widget.value,
      dropdownColor: colorScheme.background,
      hint: widget.hint != null
          ? Text(
          widget.hint!,
          style:context.textTheme.bodyText1?.rd.copyWith(
              fontWeight: FontWeight.w400,
            color: colorScheme.primary
          ),
      )
          : null,
      borderRadius: BorderRadius.circular(8),
      style: context.textTheme.bodyText1?.rd.copyWith(
          fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.background,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w,),
        prefixIcon: Icon(Icons.keyboard_arrow_down_rounded,
            color: colorScheme.primary),
      ),
    );
  }
}
