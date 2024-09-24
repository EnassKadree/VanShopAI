part of 'update_order_cubit.dart';

sealed class UpdateOrderState {}

final class UpdateOrderInitial extends UpdateOrderState {}

final class UpdateOrderLoading extends UpdateOrderState {}
final class UpdateOrderSuccess extends UpdateOrderState {}
final class UpdateOrderFailure extends UpdateOrderState {}
