part of 'get_products_cubit.dart';

sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}
final class GetProductsFailure extends GetProductsState 
{
  final String error;
  GetProductsFailure(this.error);
}
final class GetProductsSuccess extends GetProductsState {}

