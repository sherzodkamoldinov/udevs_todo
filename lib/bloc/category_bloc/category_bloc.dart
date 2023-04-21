import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository categoryRepository = CategoryRepository();
  CategoryBloc() : super(const CategoryState()) {
    on<CategoryFirstInit>(
      (event, emit) async {
        emit(state.copyWith(categoryStatus: FormzStatus.submissionInProgress));
        try {
          // add categories when first open app
          await categoryRepository.firstInit();

          add(GetCategoryEvent());
        } catch (e) {
          emit(state.copyWith(categoryStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
        }
      },
    );
    on<AddCategoryEvent>(
      (event, emit) async {
        emit(state.copyWith(categoryStatus: FormzStatus.submissionInProgress));
        try {
          // add category to cache
          await categoryRepository.addCategory(category: event.categoryModel);

          add(GetCategoryEvent());
        } catch (e) {
          debugPrint('Error in add: ${e.toString()}');
          emit(state.copyWith(categoryStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
        }
      },
    );

    on<GetCategoryEvent>(
      (event, emit) {
        emit(state.copyWith(categoryStatus: FormzStatus.submissionInProgress));
        // here get todos from hive
        try {
          var categories = categoryRepository.getCategory();
          emit(state.copyWith(categories: categories, categoryStatus: FormzStatus.submissionSuccess));
        } catch (e) {
          debugPrint('Error in get: ${e.toString()}');
          emit(state.copyWith(categoryStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
        }
      },
    );

    on<DeleteCategoryEvent>(
      (event, emit) {
        // here delete category
      },
    );
    
    on<UpdateCategoryEvent>(
      (event, emit) {
        // here update Category
      },
    );
  }
}
