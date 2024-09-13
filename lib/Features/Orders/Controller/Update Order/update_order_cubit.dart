import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Features/Core/Model/order.dart';

import '../../../Core/Helper/constants.dart';

part 'update_order_state.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderState> 
{
  UpdateOrderCubit() : super(UpdateOrderInitial());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateOrderStatus(OrderModel order) async
  {
    emit(UpdateOrderLoading());
    try
    {
      await firestore.collection(ordersConst).doc(order.id).update({'status' : 'تم التسليم'});
      emit(UpdateOrderSuccess());
    }
    catch(e)
    {
      emit(UpdateOrderFailure());
    }
  }
}
