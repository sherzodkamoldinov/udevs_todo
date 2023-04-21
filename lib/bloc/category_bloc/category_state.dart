part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.categoryStatus = FormzStatus.pure,
    this.categories = const [],
    this.errMessage = '',
  });

  final FormzStatus categoryStatus;
  final List<CategoryHiveModel> categories;
  final String errMessage;

  CategoryState copyWith({
    FormzStatus? categoryStatus,
    List<CategoryHiveModel>? categories,
    String? errMessage,
  }) =>
      CategoryState(
        errMessage: errMessage ?? this.errMessage,
        categories: categories ?? this.categories,
        categoryStatus: categoryStatus ?? this.categoryStatus,
      );

  @override
  List<Object?> get props => [categoryStatus, categories, errMessage];
}
