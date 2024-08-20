part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class CountryChanged extends SignUpState 
{
  final String? selectedCountry;
  CountryChanged(this.selectedCountry);
}

class SubscriptionPlanChanged extends SignUpState 
{
  final String selectedPlan;
  SubscriptionPlanChanged(this.selectedPlan);
}

class ProvinceChanged extends SignUpState 
{
  final String selectedProvince;
  ProvinceChanged(this.selectedProvince);
}

class CompanyChanged extends SignUpState 
{
  final String selectedCompany;
  CompanyChanged(this.selectedCompany);
}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState 
{
  final String error;
  SignUpFailure(this.error);
}

class SignUpSuccess extends SignUpState {}
