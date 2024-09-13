part of 'get_order_details_cubit.dart';

sealed class GetOrderDetailsState {}

final class GetOrderDetailsInitial extends GetOrderDetailsState {}
final class GetOrderDetailsLoading extends GetOrderDetailsState {}
final class GetOrderDetailsSuccess extends GetOrderDetailsState {}
final class GetOrderDetailsFailure extends GetOrderDetailsState {}
