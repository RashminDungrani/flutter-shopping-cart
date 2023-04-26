import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_cart/app/models/models.dart';
import 'package:shopping_cart/utils/api/api_helper.dart';
import 'package:shopping_cart/utils/api/map_extension.dart';
import 'package:shopping_cart/utils/log_helper.dart';

import '../../../data/api_paths.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() : super(ProductsListLoading()) {
    on<ProductsListStarted>(onStarted);
  }

  Future<void> onStarted(
    ProductsListStarted event,
    Emitter<ProductsListState> emit,
  ) async {
    emit(ProductsListLoading());

    // * API: Get products
    final apiHelper = ApiHelper(
      serviceName: "Get Products",
      endPoint: ApiPaths.products,
    );
    final result = await apiHelper.get();
    result.fold((l) {
      Log.error(l.pprint());
      emit(ProductsListError());
    }, (r) {
      try {
        final productsData = ProductsListModel.fromJson(r);
        emit(ProductsListLoaded(productsData.products));
      } catch (error, _) {
        Log.error(error);
        emit(ProductsListError());
      }
    });
  }
}
