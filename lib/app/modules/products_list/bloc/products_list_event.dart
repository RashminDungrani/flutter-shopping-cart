part of 'products_list_bloc.dart';

abstract class ProductsListEvent extends Equatable {
  const ProductsListEvent();
  @override
  List<ProductItem> get props => [];
}

class ProductsListStarted extends ProductsListEvent {
  List<ProductItem> get cartItems => [];
}
