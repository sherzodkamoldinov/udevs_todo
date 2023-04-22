part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CategoryFirstInit extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  const DeleteCategoryEvent({required this.categoryId});
  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}

class GetCategoryEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  const AddCategoryEvent({
    required this.categoryModel,
  });
  final CategoryHiveModel categoryModel;

  @override
  List<Object?> get props => [categoryModel];
}
