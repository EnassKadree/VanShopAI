part of 'get_orders_cubit.dart';

sealed class GetOrdersState {}

final class GetOrdersInitial extends GetOrdersState {}
final class GetOrdersLoading extends GetOrdersState {}
final class GetOrdersSuccess extends GetOrdersState {}
final class GetOrdersFailure extends GetOrdersState 
{
  final String error;
  GetOrdersFailure(this.error);
}
