import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Products%20Cubit/get_products_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/order.dart';
import 'package:vanshopai/View/Representative/Widgets/storeradiolistview.dart';
import 'package:vanshopai/View/Widgets/custombutton.dart';
import 'package:vanshopai/View/Widgets/progressindicator.dart';
import 'package:vanshopai/sharedprefsUtils.dart';
import '../../Cubits/Representative/Add Order Cubit/add_order_cubit.dart';
import 'Widgets/repproductcard.dart';

class AddRepOrderPage extends StatelessWidget {
  const AddRepOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    final productsCubit = BlocProvider.of<GetProductsCubit>(context);
    final storesCubit = BlocProvider.of<GetStoresCubit>(context);
    final addOrderCubit = BlocProvider.of<AddOrderCubit>(context);
    productsCubit.getProducts();
    storesCubit.getStores();

    final Map<String, int> selectedProducts = {};

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'تم',
          onTap: () {
            if (storesCubit.selectedStore == null) {
              ShowSnackBar(context, 'يرجى اختيار متجر قبل تقديم الطلب!');
              return;
            }

            final orderProducts = selectedProducts.entries
                .where((entry) => entry.value > 0)
                .map((entry) =>
                    {'product_id': entry.key, 'quantity': entry.value})
                .toList();

            if (orderProducts.isEmpty) {
              ShowSnackBar(context, 'يرجى إضافة منتجات قبل تقديم الطلب');
              return;
            }

            final order = OrderModel(
              distributorId: prefs.getString('userID'),
              storeId: storesCubit.selectedStore!.id,
              products: orderProducts,
              status: 'قيد التجهيز',
            );

            addOrderCubit.addOrder(order);
          },
        ),
      ),
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
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إنشاء طلبية',
                    style: TextStyle(
                        color: Colors.orange[700]!,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'اختر المتجر',
                    style: TextStyle(
                        color: Colors.orange[700]!,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<GetStoresCubit, GetStoresState>(
                      builder: (context, state) {
                    return storesBuilder(context, state);
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'اختر الطلبية',
                    style: TextStyle(
                        color: Colors.orange[700]!,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<GetProductsCubit, GetProductsState>(
                    builder: (context, state) {
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
}

storesBuilder(context, state) {
  final cubit = BlocProvider.of<GetStoresCubit>(context);
  if (state is GetStoresLoading) {
    return const MyProgressIndicator();
  } else if (state is GetStoresFailure) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('تعذر تحميل المتاجر!',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(
            height: 32,
          ),
          TextButton(
              onPressed: () {
                cubit.getStores();
              },
              child: Text(
                'حاول مرة أخرى',
                style: TextStyle(color: Colors.orange[700]!),
              ))
        ],
      ),
    );
  } else {
    if (cubit.stores.isEmpty) {
      return const Center(
          child: Text(
        'لا يوجد أي متاجر متاحة في محافظتك!',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ));
    } else {
      return const StoreRadioListView();
    }
  }
}

productsBuilder(context, state, selectedProducts) {
  final cubit = BlocProvider.of<GetProductsCubit>(context);
  if (state is GetProductsLoading) {
    return const MyProgressIndicator();
  } else if (state is GetProductsFailure) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('تعذر تحميل المنتجات!',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(
            height: 32,
          ),
          TextButton(
              onPressed: () {
                cubit.getProducts();
              },
              child: Text(
                'حاول مرة أخرى',
                style: TextStyle(color: Colors.orange[700]!),
              ))
        ],
      ),
    );
  } else {
    if (cubit.products.isEmpty) {
      return const Center(
          child: Text(
        'لا يوجد أي منتجات متاحة!',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ));
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.products.length,
          itemBuilder: (context, index) {
            return RepProductCard(
              product: cubit.products[index],
              onQuantityChanged: (quantity) {
                selectedProducts[cubit.products[index].id] =
                    quantity; //* Track quantity for each product
              },
            );
          });
    }
  }
}
