part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}
final class CategoriesLoading extends CategoriesState {}
final class CategoriesSuccess extends CategoriesState 
{
  final List<String> categories;
  CategoriesSuccess(this.categories);
}
final class CategoriesFailure extends CategoriesState 
{
  final String error;
  CategoriesFailure(this.error);
}

final class CategorySelectionChanged extends CategoriesState 
{
  final List<String> selectedCategories;
  CategorySelectionChanged(this.selectedCategories);
}

final class SaveCategoriesLoading extends CategoriesState {}
final class SaveCategoriesSuccess extends CategoriesState {}
final class SaveCategoriesFailure extends CategoriesState 
{
  final String error;
  SaveCategoriesFailure(this.error);
}