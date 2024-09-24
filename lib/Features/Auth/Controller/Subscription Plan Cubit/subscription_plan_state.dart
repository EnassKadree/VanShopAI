part of 'subscription_plan_cubit.dart';

sealed class PlanState {}

final class PlanInitial extends PlanState {}
final class CompanyPlanChanged extends PlanState 
{
  final String? plan;
  CompanyPlanChanged(this.plan);
}
final class DistributorPlanChanged extends PlanState 
{
  final String? plan;
  DistributorPlanChanged(this.plan);
}

final class SavePlanLoading extends PlanState {}
final class SavePlanSuccess extends PlanState {}
final class SavePlanFailure extends PlanState 
{
  final String? error;
  SavePlanFailure(this.error);
}