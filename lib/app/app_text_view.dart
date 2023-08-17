import 'package:flutter/material.dart';

class AppTextView extends StatelessWidget {
  const AppTextView({
    Key? key,
    required this.text,
    required this.style,
    this.translation = true,
    this.adaptiveColor = true,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
    this.softWrap,
    this.textDirection,
    this.strutStyle,
    this.locale,
  }) : super(key: key);

  final String text;
  final bool translation;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final bool? softWrap;
  final TextDirection? textDirection;
  final StrutStyle? strutStyle;
  final Locale? locale;
  final bool adaptiveColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).brightness == Brightness.dark && adaptiveColor
          ? style?.copyWith(color: Theme.of(context).colorScheme.onBackground)
          : style,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      strutStyle: strutStyle,
    );
  }
}
