import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanshopai/Model/order.dart';

import '../../../constants.dart';
import '../../../sharedprefsUtils.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> 
{
  GetOrdersCubit() : super(GetOrdersInitial());
  List<OrderModel> incomingOrders = [];
  List<OrderModel> doneOrders = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getOrders() async 
  {
    emit(GetOrdersLoading());
    
    try 
    {
      final String? userId = prefs.getString('userID');

      QuerySnapshot querySnapshot = await firestore
          .collection(ordersConst)
          .where('representative_id', isEqualTo: userId)
          .get();


      List<OrderModel> incomingOrdersTemp = [];
      List<OrderModel> doneOrdersTemp = [];

      for(var doc in querySnapshot.docs)
      {
        OrderModel order = OrderModel.fromJson
        ({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });

        if(order.status == 'قيد التجهيز')
        {
          incomingOrdersTemp.add(order);
        }
        else
        {
          doneOrdersTemp.add(order);
        }
      }
      
      incomingOrders = incomingOrdersTemp;
      incomingOrders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      doneOrders = doneOrdersTemp;
      doneOrders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      emit(GetOrdersSuccess());
    } catch (e) 
    {
      emit(GetOrdersFailure(e.toString()));
    }
  }
}
