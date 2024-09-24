part of 'representatives_cubit.dart';

sealed class RepresentativesState {}

final class RepresentativesInitial extends RepresentativesState {}

final class RepresentativesLoading extends RepresentativesState {}
final class RepresentativesFailure extends RepresentativesState 
{
  final String error;
  RepresentativesFailure(this.error);
}
final class RepresentativesSuccess extends RepresentativesState {}

final class RepresentativesUpdateLoading extends RepresentativesState {}
final class RepresentativesUpdateFailure extends RepresentativesState 
{
  final String error;
  RepresentativesUpdateFailure(this.error);
}
final class RepresentativesUpdateSuccess extends RepresentativesState {}



