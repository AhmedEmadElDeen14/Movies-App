import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/enum/screen_state.dart';
import 'package:movies_app/core/errors/failure.dart';
import 'package:movies_app/features/browse_screen/data/models/CategoryModel.dart';

import '../../domain/use_cases/get_categories_usecase.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, GetCategoriesState> {
  GetCategoryUseCase getCategoryUseCase;

  CategoriesBloc({required this.getCategoryUseCase})
      : super(GetCategoriesInitState()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(state.copyWith(
        status: ScreenType.loading,
      ));
      var result = await getCategoryUseCase();
      result.fold((l) {
        emit(state.copyWith(status: ScreenType.failures, failures: l));
      }, (r) {
        emit(state.copyWith(status: ScreenType.success, categoryModel: r));
      });
    });
  }
}