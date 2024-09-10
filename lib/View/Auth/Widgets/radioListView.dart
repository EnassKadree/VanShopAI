import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Account%20Cubit/signup_account_cubit.dart';
import 'package:vanshopai/constants.dart';

class RadioListView extends StatelessWidget 
{
  const RadioListView(
      {super.key,
      required this.items,
      required this.type});
      final List<String> items;
      final String type;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<SignUpAccountCubit>(context);
    return BlocBuilder<SignUpAccountCubit, SignUpAccountState>
    (
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
          itemCount: items.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                RadioListTile<String>(
                    title: Text(
                      items[index],
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    value: items[index],
                    groupValue: 
                      type == companiesConst && cubit.companies.isNotEmpty ?
                        cubit.selectedCompany ?? cubit.companies.first
                      : type == countriesConst && cubit.countries.isNotEmpty ?
                        cubit.selectedCountry ?? cubit.countries.first
                      : type == provincesConst && cubit.provinces.isNotEmpty ?
                        cubit.selectedProvince ?? cubit.provinces.first
                      : null,
                    onChanged: (value) 
                    {
                      if (type == companiesConst) {
                        cubit.changeCompany(value!);
                      }
                      if (type == countriesConst) {
                        cubit.changeCountry(value!);
                      }
                      if (type == provincesConst) {
                        cubit.changeProvince(value!);
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(thickness: .4),
                )
              ],
            );
          }),
        ));
      },
    );
  }
}
