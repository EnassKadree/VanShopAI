part of 'store_dists_cubit.dart';

sealed class StoreDistsState {}

final class StoreDistsInitial extends StoreDistsState {}
final class StoreDistsLoading extends StoreDistsState {}
final class StoreDistsSuccess extends StoreDistsState {}
final class StoreDistsFailure extends StoreDistsState 
{
  final String error;
  StoreDistsFailure(this.error);
}
