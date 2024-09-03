import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Model/store.dart';

import '../../../constants.dart';
import '../../../sharedprefsUtils.dart';

part 'get_stores_state.dart';

class GetStoresCubit extends Cubit<GetStoresState> 
{
  GetStoresCubit() : super(GetStoresInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Store? selectedStore;
  List<Store> stores = [];

  changeStore(value)
  {
    selectedStore = value;
    emit(StoreChanged());
  }

  Future<void> getStores() async
  {
    emit(GetStoresLoading());
    try
    {
      QuerySnapshot querySnapshot = await firestore.collection(storesConst)
        .where('province', isEqualTo: prefs.getString('province'))
        .get();
      
      stores = querySnapshot.docs.map((doc) 
      {
        return Store.fromJson
        ({
          ...doc.data() as Map<String, dynamic>, 
          'id': doc.id, 
        });
    }).toList();

    emit(GetStoresSuccess());

    }catch(e)
    {
      emit(GetStoresFailure(e.toString()));
    }
  }

}
