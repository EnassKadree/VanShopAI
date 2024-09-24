import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Extensions/sharedprefsutils.dart';
import 'package:vanshopai/Features/Products/Controller/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import '../../../Core/Helper/text.dart';
import '../Components/addorderbutton.dart';
import '../Components/productsbuilder.dart';
import '../Components/storesbuilder.dart';

class AddRepOrderPage extends StatelessWidget 
{
  const AddRepOrderPage({super.key});
  @override
  Widget build(BuildContext context) 
  {
    final productsCubit = BlocProvider.of<GetProductsCubit>(context);
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    productsCubit.getProducts('company_id', prefs.getString('companyID')!);
    storesCubit.getStores(representativeConst);

    final Map<String, int> selectedProducts = {};

    return Scaffold
    (
      bottomNavigationBar: AddOrderButton
        (selectedProducts: selectedProducts, sender: representativeConst,),

      body: SingleChildScrollView
      (
        child: Padding
        (
          padding: const EdgeInsets.all(24),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              const SizedBox(height: 24,),
              Center(child: titleText('إنشاء طلبية جديدة', fontSize: 32)),
              const SizedBox(height: 16,),
              titleText('اختر المتجر'),
              BlocBuilder<GetStoresCubit, GetStoresState>
              (
                builder: (context, state) 
                {
                return storesBuilder(context, state, representativeConst);
                }
              ),
              const SizedBox(height: 16,),
              titleText('اختر المنتجات'),
              BlocBuilder<GetProductsCubit, GetProductsState>
              (
                builder: (context, state) 
                {
                  return productsBuilder(context, state, selectedProducts, 'company_id', prefs.getString('companyID')!);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

