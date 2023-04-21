part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CategoryFirstInit extends CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  const DeleteCategoryEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class UpdateCategoryEvent extends CategoryEvent {
  const UpdateCategoryEvent({
    required this.categoryModel,
  });

  final CategoryHiveModel categoryModel;

  @override
  List<Object?> get props => [
        categoryModel,
      ];
}

class AddCategoryEvent extends CategoryEvent {
  const AddCategoryEvent({
    required this.categoryModel,
  });
  final CategoryHiveModel categoryModel;

  @override
  List<Object?> get props => [categoryModel];
}
