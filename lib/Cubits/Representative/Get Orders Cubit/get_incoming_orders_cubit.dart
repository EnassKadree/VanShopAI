import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanshopai/Model/order.dart';

import '../../../constants.dart';
import '../../../sharedprefsUtils.dart';

part 'get_incoming_orders_state.dart';

class GetIncomingOrdersCubit extends Cubit<GetIncomingOrdersState> 
{
  GetIncomingOrdersCubit() : super(GetIncomingOrdersInitial());
  List<OrderModel> orders = [];
  List<String> storesNames = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getIncomingOrders() async 
  {
    emit(GetIncomingOrdersLoading());
    
    try 
    {
      final String? userId = prefs.getString('userID');

      QuerySnapshot querySnapshot = await firestore
          .collection(ordersConst)
          .where('representative_id', isEqualTo: userId)
          .where('status', isEqualTo: 'قيد التجهيز')
          .get();

      orders = querySnapshot.docs.map((doc) 
      {
        return OrderModel.fromJson
        ({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();

      if (orders.isEmpty) 
      {
        emit(GetIncomingOrdersSuccess());
        return;
      }

      List<String> storeIds = orders.map((order) => order.storeId).toList();
      
      QuerySnapshot storeSnapshot = await firestore
          .collection(storesConst)
          .where(FieldPath.documentId, whereIn: storeIds)
          .get();

      final Map<String, String> storeNamesMap = 
      {
        for (var doc in storeSnapshot.docs)
          doc.id: doc.get('trade_name') as String,
      };

      for (int i = 0; i < orders.length; i++) 
      {
        storesNames.add(storeNamesMap[orders[i].storeId] ?? 'Unknown Store');
      }

      emit(GetIncomingOrdersSuccess());

    } catch (e) 
    {
      print('======================');
      print(e.toString());
      emit(GetIncomingOrdersFailure(e.toString()));
    }
  }

}
