import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/General%20Widgets/progressindicator.dart';
import '../../Cubits/Representative/Add Order Cubit/add_order_cubit.dart';
import 'Widgets/addorderbutton.dart';
import 'Widgets/productsbuilder.dart';
import 'Widgets/storesbuilder.dart';

class AddRepOrderPage extends StatelessWidget 
{
  const AddRepOrderPage({super.key});
  @override
  Widget build(BuildContext context) 
  {
    final productsCubit = BlocProvider.of<GetProductsCubit>(context);
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    final addOrderCubit = BlocProvider.of<AddOrderCubit>(context);
    productsCubit.getProducts();
    storesCubit.getStores();

    final Map<String, int> selectedProducts = {};

    return Scaffold
    (
      bottomNavigationBar: AddOrderButton
        (storesCubit: storesCubit, selectedProducts: selectedProducts, addOrderCubit: addOrderCubit),

      body: BlocConsumer<AddOrderCubit, AddOrderState>
      (
        listener: (context, state) 
        {
          if(state is AddOrderSuccess)
          {
            ShowSnackBar(context, 'تم إضافة الطلب بنجاح');
            pop(context);
          }
          if(state is AddOrderFailure)
          {
            ShowSnackBar(context, 'حصل خطأ ما! يرجى التأكد من الاتصال بالإنترنت ثم إعادة المحاولة');
          }
        },
        builder: (context, state) 
        {
          if(state is AddOrderLoading)
          {
            return const MyProgressIndicator();
          }
          return SingleChildScrollView
          (
            child: Padding
            (
              padding: const EdgeInsets.all(24),
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  TitleText('إنشاء طلبية جديدة', fontSize: 32),
                  const SizedBox(height: 16,),
                  TitleText('اختر المتجر'),
                  BlocBuilder<GetStoresCubit, GetStoresState>
                  (
                      builder: (context, state) 
                      {
                      return storesBuilder(context, state);
                      }
                  ),
                  const SizedBox(height: 16,),
                  TitleText('اختر المنتجات'),
                  BlocBuilder<GetProductsCubit, GetProductsState>
                  (
                    builder: (context, state) 
                    {
                      return productsBuilder(context, state, selectedProducts);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget TitleText(String title, {double fontSize = 24}) 
  {
    return Text
    (
      title,
      style: TextStyle(
        color: Colors.orange[700]!,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

