import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Home/View/storehome.dart';
import 'package:vanshopai/Features/Orders/Controller/Add%20Order%20Cubit/add_order_cubit.dart';
import 'package:vanshopai/Features/Orders/Controller/Get%20Orders%20Cubit/get_orders_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Home/View/disthome.dart';
import 'package:vanshopai/Features/Orders/View/Components/custombutton.dart';
import 'package:vanshopai/Features/Home/View/rephome.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../Core/Helper/navigators.dart';
import '../../../Core/Helper/snackbar.dart';
import '../../../../Components/progressindicator.dart';

class OrderReviewPage extends StatelessWidget 
{
  const OrderReviewPage({
    super.key,
    required this.storeName,
    required this.orderProducts,
    required this.totalPrice,
    required this.onConfirmOrder,
    required this.sender,
    this.store = false
  });

  final String storeName;
  final List<Map<String, dynamic>> orderProducts;
  final double totalPrice;
  final VoidCallback onConfirmOrder;
  final String sender;
  final bool store;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
        bottomNavigationBar: Padding
        (
          padding: const EdgeInsets.all(16.0),
          child: CustomButton
          (
            text: 'إرسال الطلب',
            onTap: onConfirmOrder,
          ),
        ),
        body: BlocConsumer<AddOrderCubit, AddOrderState>
        (
          listener: (context, state) 
          {
            if(state is AddOrderSuccess)
            {
              ShowSnackBar(context, 'تم إضافة الطلب بنجاح');
              if(store)
              {
                navigateRemoveUntil(context, const StoreHome());
              }
              else if(sender == representativeConst)
              {
                BlocProvider.of<GetOrdersCubit>(context).getOrders(sender, false);
                navigateRemoveUntil(context, const RepresentativeHome());
              }
              else if(sender == distributorsConst)
              {
                BlocProvider.of<GetOrdersCubit>(context).getOrders(sender, false);
                navigateRemoveUntil(context, const DistributorHome());
              }
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
            return Padding
            (
              padding: const EdgeInsets.all(24),
              child: ListView
              (
                children:
                [
                  Center(child: TitleText('مراجعة الطلبية', fontSize: 32)),
                  const SizedBox(
                    height: 24,
                  ),
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [
                      TitleText('الزبون:'),
                      const SizedBox(
                        width: 8,
                      ),
                      Text
                      (
                        storeName,
                        softWrap: true,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.brown),
                      ),
                    ],
                  ),
                  const SizedBox
                  (
                    height: 8,
                  ),
                  TitleText('المنتجات:'),
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
                      itemCount: orderProducts.length,
                      itemBuilder: (context, index) {
                        final product = orderProducts[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product['product_name'],
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
                      TitleText('الإجمالي:  ', fontSize: 20),
                      Text('\$${totalPrice.toStringAsFixed(2)}',
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
