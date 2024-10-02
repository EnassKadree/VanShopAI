import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Products/Controller/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Core/Model/distributor.dart';
import 'package:vanshopai/Features/Core/Model/representative.dart';
import 'package:vanshopai/Features/Core/Model/store.dart';
import '../../../../Extensions/sharedprefsutils.dart';
import '../../../Core/Helper/text.dart';
import '../Components/addorderbutton.dart';
import '../Components/productsbuilder.dart';

class AddStoreOrderPage extends StatelessWidget 
{
  const AddStoreOrderPage({super.key, this.distributor ,this.representative});
  final Distributor? distributor;
  final Representative? representative;

  @override
  Widget build(BuildContext context) 
  {
    final productsCubit = BlocProvider.of<GetProductsCubit>(context);
    final productsOwner = distributor != null ? 'distributor_id': 'company_id';
    final ownerId =  distributor != null? distributor!.id : representative!.companyId;
    productsCubit.getProducts
      (productsOwner, ownerId);
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    storesCubit.selectedStore = Store
    (
      id: prefs.getString('userID')!, 
      tradeName: prefs.getString('name')!, 
      country: prefs.getString('country')!, 
      province: prefs.getString('province')!, 
      address: prefs.getString('address')!, 
      email: prefs.getString('email')!, 
      phone: prefs.getString('phone')!
    );

    final Map<String, int> selectedProducts = {};

    return Scaffold
    (
      bottomNavigationBar: AddOrderButton
        (
          selectedProducts: selectedProducts, 
          sender: distributor != null? distributorsConst : representativeConst,
          senderId: distributor != null ? distributor!.id : representative!.id,
        ),

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
              titleText('اختر المنتجات'),
              BlocBuilder<GetProductsCubit, GetProductsState>
              (
                builder: (context, state) 
                {
                  return productsBuilder(context, state, selectedProducts, productsOwner, ownerId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

