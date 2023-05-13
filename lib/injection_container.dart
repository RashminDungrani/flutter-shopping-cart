import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/utils/api/network_info.dart';

import 'app/db/drift/database.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  _initExternal();
  // _initCore();
  // _initFeatures();
}

void _initExternal() {
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(Connectivity()));
  sl.registerSingleton<AppDatabase>(AppDatabase());
}
