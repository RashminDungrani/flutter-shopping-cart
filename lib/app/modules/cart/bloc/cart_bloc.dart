import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../main.dart';
import '../../../db/drift/DAOs/cart_item_dao.dart';
import '../../../db/drift/database.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onProductAdded);
    on<CartItemRemoved>(_onProductRemove);
  }

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final List<CartItemTblData> cartItemsInDB =
        await CartItemDao(db).selectAllCartItems;

    emit(CartLoaded(cartItemsInDB));
  }

  Future<void> _onProductAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    await CartItemDao(db).insertCartItem(event.item);
    if (state is CartLoaded) {
      try {
        emit(CartLoaded([
          ...state.cartProducts,
          CartItemTblData(
            id: event.item.id,
            price: event.item.price.toDouble(),
            description: event.item.description,
            createdAt: event.item.createdAt,
            title: event.item.title,
            featuredImage: event.item.featuredImage,
          ),
        ]));
      } catch (error) {
        emit(CartError());
      }
    }
  }

  Future<void> _onProductRemove(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    await CartItemDao(db).deleteOneProductItem(productId: event.item.id);
    if (state is CartLoaded) {
      try {
        emit(CartLoaded([...state.cartProducts]..remove(event.item)));
      } catch (error) {
        emit(CartError());
      }
    }
  }
}
