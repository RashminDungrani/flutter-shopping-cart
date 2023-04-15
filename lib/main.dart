import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'app/db/drift/database.dart';
import 'app/modules/cart/bloc/cart_bloc.dart';
import 'app/modules/cart/cart_view.dart';
import 'app/modules/products_list/bloc/products_list_bloc.dart';
import 'app/modules/products_list/products_list_view.dart';
import 'simple_bloc_observer.dart';
import 'utils/api/api_helper.dart';
import 'utils/api/network_info.dart';

late AppDatabase db;

Future<void> main() async {
  Bloc.observer = const SimpleBlocObserver();
  networkInfo = NetworkInfoImpl(Connectivity());

  db = AppDatabase();

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsListBloc>(
          create: (_) => ProductsListBloc()..add(ProductsListStarted()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc()..add(CartStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: ResponsiveWrapper.builder(
            child,
            maxWidth: 1440,
            minWidth: 320,
            defaultScale: true,
            breakpointsLandscape: [
              const ResponsiveBreakpoint.autoScale(550, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ],
            breakpoints: [
              // const ResponsiveBreakpoint.autoScale(320, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(1150, name: TABLET),
              // const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ],
            // background: const ColoredBox(color: blackColor)),
          ),
        ),
        initialRoute: "/",
        routes: {
          "/": (_) => const ProductListView(),
          "/cart": (_) => const CartView(),
        },
      ),
    );
  }
}
