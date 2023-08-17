import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import '../../../core/utils/theme_state.dart';
import '../../common/constant/design/assets_provider.dart';
import '../blocs/app_bloc/app_bloc.dart';
import '../blocs/app_bloc/app_event.dart';
import '../blocs/app_bloc/app_state.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends ThemeState<AppBottomNavBar> {
  late AppBloc appBloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (oldState, newState) =>
          oldState.currentIndex != newState.currentIndex,
      builder: (context, state) {
        return Container(
          width: 1.sw,
          height: 70.h,
          decoration: BoxDecoration(
            color: colorScheme.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: colorScheme.black.withOpacity(0.1),
                  blurRadius: 6)
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => appBloc.add(ChangeBasePage(0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.menuSvg,
                        color: state.currentIndex != 0 ? colorScheme.grey200 : colorScheme.primary,
                        height: 30.h,
                      ),
                      10.verticalSpace,
                      Text(
                        'Menu',
                        maxLines: 1,
                        style: textTheme.bodyText2?.rr.copyWith(
                            color: state.currentIndex != 0
                                ? colorScheme.grey200
                                : colorScheme.primary,
                            letterSpacing: 0.28
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => appBloc.add(ChangeBasePage(1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                              AppAssets.tableSvg,
                        color: state.currentIndex != 1 ? colorScheme.grey200 : colorScheme.primary,
                              height: 30.h,
                            ),
                      10.verticalSpace,
                      Text(
                        'Tables',
                        maxLines: 1,
                        style: textTheme.bodyText2?.rr.copyWith(
                            color: state.currentIndex != 1
                                ? colorScheme.grey200
                                : colorScheme.primary,
                        letterSpacing: 0.28
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => appBloc.add(ChangeBasePage(2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.controlSvg,
                        color: state.currentIndex != 2 ? colorScheme.grey200 : colorScheme.primary,
                        height: 30.h,
                      ),
                      10.verticalSpace,
                      Text(
                        'Control',
                        maxLines: 1,
                        style: textTheme.bodyText2?.rr.copyWith(
                            color: state.currentIndex != 2
                                ? colorScheme.grey200
                                : colorScheme.primary,
                            letterSpacing: 0.28
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
