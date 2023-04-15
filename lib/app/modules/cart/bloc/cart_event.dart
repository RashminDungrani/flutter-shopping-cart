part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartStarted extends CartEvent {
  List<CartItemTblData> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final CartItemTblData item;

  List<CartItemTblData> get props => [item];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.item);

  final CartItemTblData item;

  List<CartItemTblData> get props => [item];
}
