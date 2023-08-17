import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant/restaurant_application.dart';
import 'core/di/di_container.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp( RestaurantApplication(navKey: navigatorKey,));
}
