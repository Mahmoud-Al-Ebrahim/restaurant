import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant/common/constant/constant.dart';
import 'package:restaurant/config/theme/my_color_scheme.dart';
import 'package:restaurant/config/theme/typography.dart';
import 'package:restaurant/core/utils/extensions/build_context.dart';
import 'base_page.dart';
import 'core/domin/repositories/prefs_repository.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PrefsRepository prefsRepository = GetIt.I<PrefsRepository>();

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: context.colorScheme.primary,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.didChangeDependencies();
  }
  @override
  void initState() {

    Timer(const Duration(seconds: 4), _onSplash);
    super.initState();
  }





  _onSplash() {
    Widget child;
      child = const BasePage();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>  child), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoSvg , width: 0.25.sw, height: 0.25.sw,color: context.colorScheme.primary),
            20.verticalSpace,
            Text('WELCOME' ,
              textAlign: TextAlign.center,
              style: context.textTheme.headline1?.rr.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
