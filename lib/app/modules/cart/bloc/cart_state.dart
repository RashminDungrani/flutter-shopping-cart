part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<CartItemTblData> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemTblData> cartProducts;

  CartLoaded(this.cartProducts);

  @override
  List<CartItemTblData> get props => cartProducts;
}

class CartError extends CartState {}
