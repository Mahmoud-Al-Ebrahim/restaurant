import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/theme/app_theme.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'package:restaurant/service/screen_service.dart';
import 'package:restaurant/service/service_provider.dart';
import 'package:restaurant/splash_page.dart';
import 'common/constant/design/constant_design.dart';


class RestaurantApplication extends StatefulWidget {
  const RestaurantApplication({Key? key , required this.navKey }) : super(key: key);

  final GlobalKey<NavigatorState> navKey ;

  @override
  State<RestaurantApplication> createState() => _RestaurantApplicationState();
}

class _RestaurantApplicationState extends State<RestaurantApplication> {

  @override
  Widget build(BuildContext context) {
    ScreenService(context);
    return ScreenUtilInit(
      designSize: kDesignSize,
      minTextAdapt: true,
      builder: (context, child) {
        return ServiceProvider(
            child: Builder(
              builder: (context) {
                return MaterialApp(
                    navigatorKey: widget.navKey,
                    theme: AppTheme.light,
                    debugShowCheckedModeBanner: false,
                  home: const SplashPage()
                   );
              },
            ),
        );
      },
    );
  }
}
