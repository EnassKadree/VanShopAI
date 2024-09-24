part of 'add_store_cubit.dart';

sealed class AddStoreState {}

final class AddStoreInitial extends AddStoreState {}
final class AddStoreLoading extends AddStoreState {}
final class AddStoreSuccess extends AddStoreState {}
final class AddStoreFailure extends AddStoreState {}
