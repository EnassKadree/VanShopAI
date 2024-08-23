part of 'signup_account_cubit.dart';

@immutable
sealed class SignUpAccountState {}

final class SignUpAccountInitial extends SignUpAccountState {}


class CountryChanged extends SignUpAccountState 
{
  final String? selectedCountry;
  CountryChanged(this.selectedCountry);
}

class SubscriptionPlanChanged extends SignUpAccountState 
{
  final String selectedPlan;
  SubscriptionPlanChanged(this.selectedPlan);
}

class ProvinceChanged extends SignUpAccountState 
{
  final String selectedProvince;
  ProvinceChanged(this.selectedProvince);
}

class CompanyChanged extends SignUpAccountState 
{
  final String selectedCompany;
  CompanyChanged(this.selectedCompany);
}

class SignUpAccountLoading extends SignUpAccountState {}
class SignUpAccountFailure extends SignUpAccountState 
{
  final String error;
  SignUpAccountFailure(this.error);
}
class SignUpAccountSuccess extends SignUpAccountState {}


class GetCompaniesLoading extends SignUpAccountState {}
class GetCompaniesFailure extends SignUpAccountState 
{
  final String error;
  GetCompaniesFailure(this.error);
}
class GetCompaniesSuccess extends SignUpAccountState {}


class GetCountriesLoading extends SignUpAccountState {}
class GetCountriesFailure extends SignUpAccountState 
{
  final String error;
  GetCountriesFailure(this.error);
}
class GetCountriesSuccess extends SignUpAccountState {}


class GetProvincesLoading extends SignUpAccountState {}
class GetProvincesFailure extends SignUpAccountState 
{
  final String error;
  GetProvincesFailure(this.error);
}
class GetProvincesSuccess extends SignUpAccountState {}
