import 'dart:async';

import 'package:ecommerce_app/repositories/category/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategories>(_mapLoadCategoriesToState);
    on<UpdateCategories>(_mapUpdateCategoriesToState);
  }

  void _mapLoadCategoriesToState(CategoryEvent event, Emitter<CategoryState> emit) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen(
          (products) => add(
            UpdateCategories(products),
          ),
        );
  }

  void _mapUpdateCategoriesToState(UpdateCategories event, Emitter<CategoryState> emit) {
    emit(
      CategoryLoaded(categories: event.categories),
    );
  }
}
