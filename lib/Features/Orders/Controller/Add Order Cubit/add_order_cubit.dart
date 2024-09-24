import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Model/order.dart';

import '../../../Core/Helper/constants.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> 
{
  AddOrderCubit() : super(AddOrderInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addOrder(OrderModel order) async 
  {
    emit(AddOrderLoading());
    try 
    {
      await firestore.collection(ordersConst).add(order.toJson());
      emit(AddOrderSuccess());
    } catch (e) 
    {
      emit(AddOrderFailure(e.toString()));
    }
  }
}
