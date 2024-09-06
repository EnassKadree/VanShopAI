part of 'get_incoming_orders_cubit.dart';

sealed class GetIncomingOrdersState {}

final class GetIncomingOrdersInitial extends GetIncomingOrdersState {}
final class GetIncomingOrdersLoading extends GetIncomingOrdersState {}
final class GetIncomingOrdersSuccess extends GetIncomingOrdersState {}
final class GetIncomingOrdersFailure extends GetIncomingOrdersState 
{
  final String error;
  GetIncomingOrdersFailure(this.error);
}
