
import 'package:flutter/material.dart';

import '../../../Cubits/Representative/Add Order Cubit/add_order_cubit.dart';
import '../../../Cubits/Representative/Get Stores Cubit/get_stores_cubit.dart';
import '../../../Helper/snackbar.dart';
import '../../../Model/order.dart';
import '../../../sharedprefsUtils.dart';
import '../../General Widgets/custombutton.dart';

class AddOrderButton extends StatelessWidget 
{
  const AddOrderButton({
    super.key,
    required this.storesCubit,
    required this.selectedProducts,
    required this.addOrderCubit,
  });

  final GetStoresCubit storesCubit;
  final Map<String, int> selectedProducts;
  final AddOrderCubit addOrderCubit;

  @override
  Widget build(BuildContext context) {
    return Padding
    (
      padding: const EdgeInsets.all(16.0),
      child: CustomButton(
        text: 'تم',
        onTap: () {
          if (isStoreSelected(storesCubit)) 
          {
            ShowSnackBar(context, 'يرجى اختيار متجر قبل تقديم الطلب!');
            return;
          }
      
          final orderProducts = filterSelectedProducts(selectedProducts);
      
          if (orderProducts.isEmpty) 
          {
            ShowSnackBar(context, 'يرجى إضافة منتجات قبل تقديم الطلب');
            return;
          }
      
          final order = createOrder(storesCubit, orderProducts);
      
          addOrderCubit.addOrder(order);
        },
      ),
    );
  }

  bool isStoreSelected(GetStoresCubit storesCubit) 
  {
    return storesCubit.selectedStore != null;
  }

  List<Map<String, dynamic>> filterSelectedProducts(Map<String, int> selectedProducts) 
  {
    return selectedProducts.entries
        .where((entry) => entry.value > 0)
        .map((entry) => {'product_id': entry.key, 'quantity': entry.value})
        .toList();
  }

  OrderModel createOrder(GetStoresCubit storesCubit, List<Map<String, dynamic>> orderProducts) 
  {
    return OrderModel(
      distributorId: prefs.getString('userID'),
      storeId: storesCubit.selectedStore!.id,
      products: orderProducts,
      status: 'قيد التجهيز',
    );
  }
}