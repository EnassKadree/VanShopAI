part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoading extends ProductsState {}
final class ProductsSuccess extends ProductsState 
{
  final List<Product> products;
  ProductsSuccess(this.products);
}
final class ProductsFailure extends ProductsState 
{
  final String error;
  ProductsFailure(this.error);
}

final class AddProductLoading extends ProductsState {}
final class AddProductFailure extends ProductsState 
{
  final String error;
  AddProductFailure(this.error);
}

final class DeleteProductLoading extends ProductsState {}
final class DeleteProductFailure extends ProductsState 
{
  final String error;
  DeleteProductFailure(this.error);
}


final class UpdateProductLoading extends ProductsState {}
final class UpdateProductFailure extends ProductsState 
{
  final String error;
  UpdateProductFailure(this.error);
}

