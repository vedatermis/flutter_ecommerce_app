import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_mapStartWishlistToState);

    on<AddWishlistProduct>(_mapAddWishlistProductToState);

    on<RemoveWishlistProduct>(_mapRemoveWishlistToProductState);
  }

  void _mapStartWishlistToState(StartWishlist event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistLoading());
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (_) {}
  }

  void _mapAddWishlistProductToState(AddWishlistProduct event, Emitter<WishlistState> emit) {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((state as WishlistLoaded).wishlist.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _mapRemoveWishlistToProductState(RemoveWishlistProduct event, Emitter<WishlistState> emit) {
    try {
      emit(
        WishlistLoaded(
          wishlist: Wishlist(
            products: List.from((state as WishlistLoaded).wishlist.products)..remove(event.product),
          ),
        ),
      );
    } catch (_) {}
  }
}
