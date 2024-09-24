part of 'get_stores_cubit.dart';

sealed class GetStoresState {}

final class GetStoresInitial extends GetStoresState {}


final class GetStoresLoading extends GetStoresInitial {}
final class GetStoresFailure extends GetStoresInitial 
{
  final String error;
  GetStoresFailure(this.error);
}
final class GetStoresSuccess extends GetStoresInitial {}

final class StoreChanged extends GetStoresInitial {}
