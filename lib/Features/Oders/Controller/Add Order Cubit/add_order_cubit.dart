import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanshopai/Model/order.dart';

import '../../../../Helper/constants.dart';

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
