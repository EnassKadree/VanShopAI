import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Model/order.dart';

import '../../../../Extensions/sharedprefsutils.dart';
import '../../../Core/Helper/constants.dart';
part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> 
{
  GetOrdersCubit() : super(GetOrdersInitial());
  List<OrderModel> incomingOrders = [];
  List<OrderModel> doneOrders = [];
  List<String> distsNames = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getOrders(String sender, bool done) async 
  {
    emit(GetOrdersLoading());
    
    try 
    {
      final String? userId = prefs.getString('userID');
      String owner = 
        sender == representativeConst? 'representative_id' 
        : sender == distributorsConst ? 'distributor_id'
        : 'store_id';

      QuerySnapshot querySnapshot = await firestore
        .collection(ordersConst)
        .where(owner, isEqualTo: userId)
        .where('status' , isEqualTo: done? 'تم التسليم': 'قيد التجهيز')
        .get();

      if(done)
      {
        doneOrders = querySnapshot.docs.map((doc) 
        {
          return OrderModel.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
        }).toList();
        doneOrders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        if(sender == storesConst) { await getDistsNames(doneOrders); }
      }
      else
      {
        incomingOrders = querySnapshot.docs.map((doc) 
        {
          return OrderModel.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
        }).toList();
        incomingOrders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        if(sender == storesConst) { await getDistsNames(incomingOrders); }
      }

      emit(GetOrdersSuccess());
    } catch (e) 
    {
      emit(GetOrdersFailure(e.toString()));
    }
  }

  
  Future<void> getDistsNames(List ordersList) async
  {
    List<String> distsTemp = [];
    for (OrderModel order in ordersList) 
    {
      String distId = order.distributorId != null ? order.distributorId! : order.representativeId!;

      DocumentSnapshot distDoc = await firestore
        .collection(order.distributorId != null ? distributorsConst : representativeConst)
        .doc(distId)
        .get();

      if (distDoc.exists) 
      {
        distsTemp.add(distDoc['trade_name'] as String);
      } else
      {
        distsTemp.add("Unknown");
      }
    }
    distsNames = distsTemp;
  }
}