import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import '../../../../core/utils/responsive_padding.dart';
import '../../../common/constant/design/constant_design.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.controller,
    this.onTap,
    this.onEditingComplete,
    this.onChange,
    this.onFieldSubmitted,
    this.onSaved,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled,
    this.textInputType,
    this.textInputAction,
    this.textDirection,
    this.validator,
    this.maxLengthEnforcement,
    this.focusNode,
    this.autoValidateMode,
    this.scrollPhysics,
    this.scrollController,
    this.initialValue,
    this.keyboardAppearance,
    this.textAlignVertical,
    this.toolbarOptions,
    this.obscuringCharacter = "•",
    this.expands = false,
    this.readOnly = false,
    this.autocorrect = true,
    this.showLength = false,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.titleField,
    this.obscure = false,
    this.disableBorders = false,
    this.prefixIcon,
    this.icon,
    this.hintTextStyle,
    this.textStyle,
    this.suffixIcon,
    this.suffix,
    this.hintText,
    this.labelText,
    this.inputFormatters,
    this.contentPadding,
    this.filledColor,
    this.bordersColor,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String val)? onChange;
  final void Function(String val)? onFieldSubmitted;
  final void Function(String? val)? onSaved;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final FormFieldValidator<String?>? validator;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final TextAlignVertical? textAlignVertical;
  final ToolbarOptions? toolbarOptions;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final EdgeInsets scrollPadding;
  final bool expands;
  final bool readOnly;
  final bool autocorrect;
  final String obscuringCharacter;
  final String? titleField;
  final bool showLength;
  final bool obscure;
  final Widget? prefixIcon;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final Color? filledColor;
  final Color? bordersColor;
  final bool disableBorders;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: showLength ? maxLength : null,
      textAlign: textAlign,
      enabled: enabled,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      textDirection: textDirection,
      scrollPadding: scrollPadding,
      expands: expands,
      maxLengthEnforcement: maxLengthEnforcement,
      focusNode: focusNode,
      obscureText: obscure,
      obscuringCharacter: obscuringCharacter,
      autovalidateMode: autoValidateMode,
      readOnly: readOnly,
      scrollPhysics: scrollPhysics,
      scrollController: scrollController,
      autocorrect: false,
      cursorColor: context.colorScheme.primary,
      initialValue: initialValue,
      keyboardAppearance: keyboardAppearance,
      textAlignVertical: textAlignVertical,
      textCapitalization: textCapitalization,
      toolbarOptions: toolbarOptions,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        if (textInputType == TextInputType.phone || textInputType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ...?inputFormatters
      ],
      style:textStyle ??  context.textTheme.bodyText1?.rr.copyWith(
        color: const Color(0xff404040),
        decoration: TextDecoration.none,
        decorationColor: context.colorScheme.borderTextField,
      ),
      decoration: InputDecoration(
        border: disableBorders ? InputBorder.none  : OutlineInputBorder(
          borderSide: BorderSide(color: bordersColor ?? context.colorScheme.borderTextField,width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        focusedBorder: disableBorders ? InputBorder.none  :OutlineInputBorder(
          borderSide: BorderSide(color: bordersColor ?? context.colorScheme.borderTextField,width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        enabledBorder: disableBorders ? InputBorder.none  :OutlineInputBorder(
          borderSide: BorderSide(color: bordersColor ?? context.colorScheme.borderTextField,width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        disabledBorder:  disableBorders ? InputBorder.none  :OutlineInputBorder(
          borderSide: BorderSide(color: bordersColor ?? context.colorScheme.borderTextField,width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        errorBorder: disableBorders ? InputBorder.none  :OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error, width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        focusedErrorBorder: disableBorders ? InputBorder.none  :OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error, width: 0.4),
          borderRadius: BorderRadius.circular(kbrBorderTextField),
        ),
        filled: true,
        fillColor: filledColor ?? context.colorScheme.white,
        contentPadding: contentPadding ?? HWEdgeInsetsDirectional.only(start: 20, end: 10,bottom: 12,top: 12),
        prefixIcon: prefixIcon,
        icon: icon,
        suffixIcon: suffixIcon,
        suffix: suffix,
        hintText: hintText,
        hintStyle: hintTextStyle ?? context.textTheme.bodyText1?.rt.copyWith(color: context.colorScheme.grey200),
        labelText: labelText,
        labelStyle: context.textTheme.bodyText2?.copyWith(color: context.colorScheme.hint),
      ),
    );
  }
}
