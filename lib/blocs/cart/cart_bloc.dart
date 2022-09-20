import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_mapCartStartedToState);
    on<CartProductAdded>(_mapCartProductAddedToState);
    on<CartProductRemoved>(_mapCartProductRemovedToState);
  }

  void _mapCartStartedToState(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {}
  }

  void _mapCartProductAddedToState(CartProductAdded event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(cart: Cart(products: List.from((state as CartLoaded).cart.products)..add(event.product))));
      } catch (_) {}
    }
  }

  void _mapCartProductRemovedToState(CartProductRemoved event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(cart: Cart(products: List.from((state as CartLoaded).cart.products)..remove(event.product))));
      } catch (_) {}
    }
  }
}
