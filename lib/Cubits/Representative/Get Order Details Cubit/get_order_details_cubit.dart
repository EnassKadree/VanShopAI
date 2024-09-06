import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanshopai/constants.dart'; 
import 'package:bloc/bloc.dart';

import '../../../Model/order.dart';


part 'get_order_details_state.dart';

class GetOrderDetailsCubit extends Cubit<GetOrderDetailsState> 
{
  GetOrderDetailsCubit() : super(GetOrderDetailsInitial());
  final firestore = FirebaseFirestore.instance;

  
  getProductDetails(OrderModel order) async
  {
    try
    {
      emit(GetOrderDetailsLoading());
      List<Map<String,dynamic>> orderProductsTemp = [];
      for (var product in order.products) 
      {
        var productDoc = await firestore.collection(productsConst).doc(product['product_id']).get();
        var productData = productDoc.data();
        if (productData != null) 
        {
          orderProductsTemp.add
          ({
            'name': productData['name'],
            'price': productData['price'],
            'quantity': product['quantity'],
          });
        }
      }
      order.products = orderProductsTemp;
      emit(GetOrderDetailsSuccess());
    }catch(e)
    {
      print(e.toString());
      emit(GetOrderDetailsFailure());
    }
  }
}
