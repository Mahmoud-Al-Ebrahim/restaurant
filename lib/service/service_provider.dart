import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant/app/blocs/app_bloc/app_bloc.dart';
import 'package:restaurant/app/blocs/app_bloc/app_event.dart';
import 'package:restaurant/features/control_panel/bloc/fetch_image/fetch_image_cubit.dart';

class ServiceProvider extends StatelessWidget {
  final Widget child;
  const ServiceProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => GetIt.I<AppBloc>()..add(GetProductsEvent())..add(GetTablesEvent())),
        BlocProvider(create: (BuildContext context) => FetchImageCubit()),
    ],
      child: child,
    );
  }
}
