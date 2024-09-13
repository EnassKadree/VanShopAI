import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Products/Controller/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import '../../../../Extensions/sharedprefsUtils.dart';
import '../../../Core/Helper/text.dart';
import '../Components/addorderbutton.dart';
import '../Components/productsbuilder.dart';
import '../Components/storesbuilder.dart';

class AddDistOrderPage extends StatelessWidget 
{
  const AddDistOrderPage({super.key});
  @override
  Widget build(BuildContext context) 
  {
    final productsCubit = BlocProvider.of<GetProductsCubit>(context);
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    productsCubit.getProducts('distributor_id', prefs.getString('userID')!);
    storesCubit.getStores(distributorsConst);

    final Map<String, int> selectedProducts = {};

    return Scaffold
    (
      bottomNavigationBar: AddOrderButton
        (selectedProducts: selectedProducts, sender: distributorsConst,),

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
              Center(child: TitleText('إنشاء طلبية جديدة', fontSize: 32)),
              const SizedBox(height: 16,),
              TitleText('اختر المتجر'),
              BlocBuilder<GetStoresCubit, GetStoresState>
              (
                builder: (context, state) 
                {
                return storesBuilder(context, state, distributorsConst);
                }
              ),
              const SizedBox(height: 16,),
              TitleText('اختر المنتجات'),
              BlocBuilder<GetProductsCubit, GetProductsState>
              (
                builder: (context, state) 
                {
                  return productsBuilder(context, state, selectedProducts, 'distributor_id', prefs.getString('userID')!);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

