part of 'products_list_bloc.dart';

abstract class ProductsListState extends Equatable {
  @override
  List<ProductItem> get props => [];
}

class ProductsListLoading extends ProductsListState {}

class ProductsListLoaded extends ProductsListState {
  final List<ProductItem> products;

  ProductsListLoaded(this.products);

  @override
  List<ProductItem> get props => products;
}

class ProductsListError extends ProductsListState {}
