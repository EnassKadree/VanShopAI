import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Orders/Controller/Generate%20PDF%20Cubit/generate_pdf_cubit.dart';
import 'package:vanshopai/Features/Orders/Controller/Get%20Order%20Details%20Cubit/get_order_details_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/orderfunctions.dart';
import 'package:vanshopai/Features/Core/Model/order.dart';

import '../../../Core/Helper/text.dart';
import '../../../../Components/progressindicator.dart';

class OrderDetailsPage extends StatelessWidget 
{
  const OrderDetailsPage
  ({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetOrderDetailsCubit>(context);
    final pdfCubit = BlocProvider.of<GeneratePdfCubit>(context);
    cubit.getProductDetails(order);
    return Scaffold(
        floatingActionButton: BlocBuilder<GeneratePdfCubit, GeneratePdfState>
        (
          builder: (context, state) 
          {
            if(state is GeneratePDFLoading)
            {
              return FloatingActionButton.extended
              (
                  backgroundColor: Colors.blue[900],
                  icon: const Icon(
                    Iconsax.menu,
                    color: Colors.white,
                  ),
                  label: const Text('جارٍ التحميل...', style: TextStyle(color: Colors.white)),
                  onPressed: null
              );
            }
            else
            {
              return FloatingActionButton.extended
              (
                  backgroundColor: Colors.blue[900],
                  icon: const Icon(
                    Iconsax.share,
                    color: Colors.white,
                  ),
                  label: const Text('مشاركة', style: TextStyle(color: Colors.white)),
                  onPressed: () async 
                  {
                    await pdfCubit.shareOrder(order);
                  }
              );
            }
          },
    ), 
    body: BlocBuilder<GetOrderDetailsCubit, GetOrderDetailsState>(
      builder: (context, state) {
        if (state is GetOrderDetailsLoading) 
        {
          return const MyProgressIndicator();
        } else if (state is GetOrderDetailsFailure) 
        {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('تعذر تحميل تفاصيل الطلب!'),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () async {
                      await cubit.getProductDetails(order);
                    },
                    child: Text(
                      'حاول مرة أخرى',
                      style: TextStyle(color: Colors.orange[700]!),
                    ))
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Center(child: titleText('تفاصيل الطلب', fontSize: 32)),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText('الزبون:'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    order.storeName,
                    softWrap: true,
                    style: const TextStyle(fontSize: 22, color: Colors.brown),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              titleText('المنتجات:'),
              const SizedBox(
                height: 20,
              ),
              //const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اسم المنتج',
                    style: TextStyle(color: Colors.brown, fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    'الكمية',
                    style: TextStyle(color: Colors.brown, fontSize: 18),
                  ),
                  SizedBox(width: 24),
                  Text(
                    'السعر',
                    style: TextStyle(color: Colors.brown, fontSize: 18),
                  )
                ],
              ),
              const Divider(),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.products.length,
                  itemBuilder: (context, index) {
                    final product = order.products[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                    color: Colors.blue[900], fontSize: 18),
                              ),
                              const Spacer(),
                              Text(
                                '${product['quantity']}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 54,
                              ),
                              Text(
                                '${product['price'] * product['quantity']}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }),
              const SizedBox(height: 16),
              Row(
                children: [
                  titleText('الإجمالي:  ', fontSize: 20),
                  Text(
                      '\$${calculateTotalPrice(order.products).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.brown,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
