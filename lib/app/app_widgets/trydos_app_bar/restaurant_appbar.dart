import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import '../../../../core/utils/responsive_padding.dart';
import '../../../common/constant/design/assets_provider.dart';
import 'app_bar_params.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantAppBar({
    Key? key,
    required this.appBarParams,
  }) : super(key: key);

  final AppBarParams appBarParams;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.black.withOpacity(0.1),
                offset: const Offset(0,0),
                blurRadius: 6
              )
            ]
          ),
          child: AppBar(
            //title: title(context),
            backgroundColor: appBarParams.backgroundColor ??
                Theme.of(context).colorScheme.surface,
            leading: leadingAppBar(context),
            actions: appBarParams.action,
            centerTitle: appBarParams.centerTitle,
            elevation: appBarParams.elevation,
            shadowColor: appBarParams.shadowColor,
            surfaceTintColor: appBarParams.surfaceTintColor,
            shape: appBarParams.shape,
            flexibleSpace: appBarParams.child,

          ),
        ),
        if (appBarParams.dividerBottom)
          Divider(height: 0, endIndent: 25.w, indent: 25.w)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  Widget title(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          (appBarParams.action?.isNotEmpty ?? true)
              ? 0
              : -30,
          0),
      child: Row(
        mainAxisAlignment: appBarParams.centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appBarParams.child != null) ...{
            5.horizontalSpace,
            appBarParams.child!,
          },
          if (appBarParams.title != null)
            Text(
               appBarParams.title!,
              style: appBarParams.tittleStyle ??
                  Theme.of(context).textTheme.headline3?.copyWith(
                        color: appBarParams.textColor,
                      ),
            ),
        ],
      ),
    );
  }

  Widget leadingAppBar(BuildContext context) => appBarParams.hasLeading
      ? InkWell(
    onTap: (){
      Navigator.pop(context);
    },
    child: Padding(
      padding: HWEdgeInsets.symmetric(vertical: 15),
      child: SvgPicture.asset(
        AppAssets.backButtonSvg,
        width: 8.w,
        color: const Color(0xff388CFF),
      ),
    ),
  )
      : const SizedBox();
}
