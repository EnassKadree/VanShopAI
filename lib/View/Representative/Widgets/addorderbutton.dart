
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/constants.dart';
import '../../../Cubits/Representative/Add Order Cubit/add_order_cubit.dart';
import '../../../Cubits/Representative/Get Stores Cubit/get_stores_cubit.dart';
import '../../../Helper/orderfunctions.dart';
import '../../../Helper/snackbar.dart';
import '../../../Model/order.dart';
import '../../../sharedprefsUtils.dart';
import '../../General Widgets/custombutton.dart';
import '../orderreviewpage.dart';

class AddOrderButton extends StatelessWidget 
{
  const AddOrderButton
  ({
    super.key,
    required this.selectedProducts,
    required this.sender
  });

  final Map<String, int> selectedProducts;
  final String sender;

  @override
  Widget build(BuildContext context) 
  {
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: CustomButton(
        text: 'تم',
        onTap: () 
        {
          if (!isStoreSelected(storesCubit)) 
          {
            ShowSnackBar(context, 'يرجى اختيار متجر قبل تقديم الطلب!');
            return;
          }
      
          final orderProducts = filterSelectedProducts(selectedProducts, context);
      
          if (orderProducts.isEmpty) 
          {
            ShowSnackBar(context, 'يرجى إضافة منتجات قبل تقديم الطلب');
            return;
          }

          final totalPrice = calculateTotalPrice(orderProducts);

          navigateTo(context, OrderReviewPage
          (
            storeName: storesCubit.selectedStore!.tradeName, 
            orderProducts: orderProducts, 
            totalPrice: totalPrice, 
            onConfirmOrder:  () => confirmOrder(context, storesCubit, sender),
            sender: sender
          ));
        },
      ),
    );
  }

  bool isStoreSelected(GetStoresCubit storesCubit) 
  {
    return storesCubit.selectedStore != null;
  }

List<Map<String, dynamic>> filterSelectedProducts(Map<String, int> selectedProducts, context) 
{
  final productsCubit = BlocProvider.of<GetProductsCubit>(context);
  return selectedProducts.entries
      .where((entry) => entry.value > 0)
      .map((entry) => 
      {
        'product_id': entry.key,
        'quantity': entry.value,
        'product_name': productsCubit.getProductNameById(entry.key),
        'price': productsCubit.getProductPriceById(entry.key),
      })
      .toList();
}

  void confirmOrder(BuildContext context, GetStoresCubit storesCubit, String sender)
  {
    final addOrderCubit = BlocProvider.of<AddOrderCubit>(context);
    if(sender == representativeConst)
    {
      final order = OrderModel
      (
        representativeId: prefs.getString('userID'),
        storeId: storesCubit.selectedStore!.id,
        products: filterSelectedProducts(selectedProducts, context),
        status: 'قيد التجهيز',
        storeName: storesCubit.selectedStore!.tradeName
      );
      addOrderCubit.addOrder(order);
    }
    else if(sender == distributorsConst)
    {
      print('<<<<<<<<<<<<<<<<<<<<<<<<................');
      print(storesCubit.selectedStore.toString());
      final order = OrderModel
      (
        distributorId: prefs.getString('userID'),
        storeId: storesCubit.selectedStore!.id,
        products: filterSelectedProducts(selectedProducts, context),
        status: 'قيد التجهيز',
        storeName: storesCubit.selectedStore!.tradeName
      );
      addOrderCubit.addOrder(order);
    }
  }
}