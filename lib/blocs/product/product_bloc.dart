import 'dart:async';

import 'package:ecommerce_app/repositories/product/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_mapLoadProductToState);
    on<UpdateProducts>(_mapUpdateProductToState);
  }

  FutureOr<void> _mapLoadProductToState(LoadProducts event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProduct().listen((products) => add(UpdateProducts(products)));
  }

  FutureOr<void> _mapUpdateProductToState(UpdateProducts event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }
}
