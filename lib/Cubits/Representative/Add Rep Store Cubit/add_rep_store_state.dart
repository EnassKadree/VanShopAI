part of 'add_rep_store_cubit.dart';

@immutable
sealed class AddRepStoreState {}

final class AddRepStoreInitial extends AddRepStoreState {}
final class AddRepStoreLoading extends AddRepStoreState {}
final class AddRepStoreSuccess extends AddRepStoreState {}
final class AddRepStoreFailure extends AddRepStoreState {}
