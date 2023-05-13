import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/modules/cart/bloc/cart_bloc.dart';
import 'app/modules/cart/cart_view.dart';
import 'app/modules/products_list/bloc/products_list_bloc.dart';
import 'app/modules/products_list/products_list_view.dart';
import 'injection_container.dart';
import 'simple_bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = const SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await initDI();

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
      child: MaterialApp.router(
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 480, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              // const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            // child: child!,
            child: MaxWidthBox(
              maxWidth: 922,
              background: Container(color: Colors.white),
              child: Builder(builder: (context) {
                return ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 800),
                    const Condition.between(start: 0, end: 800),
                    const Condition.equals(name: TABLET, value: 1200),
                    const Condition.between(start: 481, end: 922),
                    // There are no conditions for width over 922
                    // because the `maxWidth` is set to 922 via the MaxWidthBox.
                  ]).value,
                  child: child!,
                );
              }),
            ),
          ),
        ),
        routerConfig: GoRouter(routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const ProductListView(),
          ),
          GoRoute(
            path: "/cart",
            builder: (context, state) => const CartView(),
          ),
        ]),
      ),
    );
  }
}
