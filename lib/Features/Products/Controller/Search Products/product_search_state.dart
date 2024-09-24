part of 'product_search_cubit.dart';

sealed class ProductSearchState {}

final class ProductSearchInitial extends ProductSearchState {}

class ProductSearchLoading extends ProductSearchState {}

class ProductSearchSuccess extends ProductSearchState 
{
  final List<Product> products;
  final List<String> owners; 
  
  ProductSearchSuccess(this.products, this.owners);
}

class ProductSearchFailure extends ProductSearchState
{
  final String error;
  
  ProductSearchFailure(this.error);
}