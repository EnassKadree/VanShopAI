// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Account%20Cubit/signup_account_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/radioListView.dart';
import 'package:vanshopai/constants.dart';

class ChoiceButton extends StatelessWidget {
  ChoiceButton({super.key, this.onTap, required this.type});
  void Function()? onTap;
  String type;

  @override
  Widget build(BuildContext context) 
  {
    final String text = type == companiesConst
        ? 'الشركة التي تعمل لديها'
        : type == countriesConst
            ? 'البلد'
            : 'المحافظة';
    final cubit = BlocProvider.of<SignUpAccountCubit>(context);
    return InkWell(
        onTap: () 
        {
          if (type == companiesConst) {
            cubit.getCompanies();
            showBottomSheet(context, text);
          }
          if (type == countriesConst) {
            cubit.getCountries();
            showBottomSheet(context, text);
          }
          if (type == provincesConst) 
          {
            try
            {
              cubit.getProvinces(cubit.selectedCountry!);
              showBottomSheet(context, text);
            }catch(e)
            {
              ShowSnackBar(context, 'يرجى اختيار بلد أولاً قبل اختيار المحافظة');
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.blue[900]!, fontSize: 18),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.blue[900]!,
              )
            ],
          ),
        ));
  }

  Future<dynamic>? showBottomSheet(BuildContext context, String text) 
  {
      final cubit = BlocProvider.of<SignUpAccountCubit>(context);
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return BlocBuilder<SignUpAccountCubit, SignUpAccountState>
            (
              builder: (context, state) 
              {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('اختر$text',
                          style: TextStyle(color: Colors.orange[700]!, fontSize: 24)),

                          if (state is GetCompaniesLoading ||  state is GetCountriesLoading ||  state is GetProvincesLoading)
                            Center( child: CircularProgressIndicator(color: Colors.orange[700]!,),)
                        else if (state is GetCompaniesFailure || state is GetCountriesFailure || state is GetProvincesFailure)
                          const Center( child: Text('فشل التحميل، يرجى التأكد من اتصالك بالإنترنت ثم إعادة المحاولة', ),)
                        else if (state is GetCompaniesSuccess && cubit.companies.isEmpty ||
                            state is GetCountriesSuccess &&  cubit.countries.isEmpty ||
                            state is GetProvincesSuccess && cubit.provinces.isEmpty)
                          const Text('لا يوجد بيانات متاحة',style: TextStyle(fontSize: 18),)
                        else if
                        (
                          state is GetCompaniesSuccess || state is GetCountriesSuccess  || state is GetProvincesSuccess ||
                          state is CompanyChanged || state is ProvinceChanged || state is CountryChanged
                        )
                          RadioListView
                          (
                            type: type,
                            items: type == companiesConst
                                ? cubit.companies
                                : type == countriesConst
                                    ? cubit.countries
                                    : cubit.provinces,
                          ),
                      CustomButton(
                        text: 'تم',
                        onTap: () 
                        {
                          pop(context);
                        },
                      )
                    ],
                  ),
                );
              },
            );
          });
  }
}
