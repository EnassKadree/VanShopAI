import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Extensions/sharedprefsUtils.dart';

import '../../../../Model/store.dart';

part 'add_store_state.dart';

class AddStoreCubit extends Cubit<AddStoreState> 
{
  AddStoreCubit() : super(AddStoreInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance; 

  Future<void> addUserStore(Store store, GetStoresCubit cubit, sender) async
  {
    emit(AddStoreLoading());

    try
    {
      cubit.stores.add(store);
      cubit.recommendedStores.remove(store);

      await fireStore.collection(sender)
        .doc(prefs.getString('userID'))
        .update
        ({
          'stores' : cubit.stores.map((doc) => doc.id).toList()
        });

      emit(AddStoreSuccess());

      cubit.getRecommendedStores(sender);
      cubit.getStores(sender);
    }catch(e)
    {
      emit(AddStoreFailure());
    }
  }
}
