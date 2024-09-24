import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Model/store.dart';
import '../../../Core/Helper/constants.dart';
import '../../../../Extensions/sharedprefsutils.dart';
part 'get_stores_state.dart';

class GetStoresCubit extends Cubit<GetStoresState> 
{
  GetStoresCubit() : super(GetStoresInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Store? selectedStore;
  List<Store> recommendedStores = [];
  List<Store> stores = [];

  changeStore(value)
  {
    selectedStore = value;
    emit(StoreChanged());
  }

  Future<void> getStores(String sender) async
  {
    emit(GetStoresLoading());
    try
    {
      DocumentSnapshot documentSnapshot = await firestore.collection(sender)
        .doc(prefs.getString('userID'))
        .get();

      List? storesIds = documentSnapshot['stores'];

      if(storesIds != null && storesIds.isNotEmpty)
      {
        QuerySnapshot querySnapshot = await firestore.collection(storesConst)
          .where(FieldPath.documentId, whereIn:storesIds)
          .get();
        
        stores = querySnapshot.docs.map((doc) 
        {
          return Store.fromJson
          ({
            ...doc.data() as Map<String, dynamic>, 
            'id': doc.id, 
          });
        }).toList();
      }
      if(stores.isNotEmpty) {selectedStore = stores.first;}

    emit(GetStoresSuccess());

    }catch(e)
    {
      emit(GetStoresFailure(e.toString()));
    }
  }

  Future<void> getRecommendedStores(String sender) async
  {
    emit(GetStoresLoading());
    try
    {
      String ownerCollection = sender == representativeConst? companiesConst : distributorsConst;
      String ownerId = sender == representativeConst? prefs.getString('companyID')! : prefs.getString('userID')!;
      DocumentSnapshot documentSnapshot = await firestore
      .collection(ownerCollection)
      .doc(ownerId)
      .get();

      List? categories = documentSnapshot['categories'];


      List? storesIds = stores.map((doc) => doc.id).toList();

      QuerySnapshot querySnapshot = await firestore
        .collection(storesConst)
        .where('province', isEqualTo: prefs.getString('province'))
        .get();


      recommendedStores = querySnapshot.docs.where((doc) 
      {
        List? storeCategories = doc['categories'];
        String storeId = doc.id;

        bool notInUserStores = !storesIds.contains(storeId);
        bool hasCommonCategory = storeCategories != null &&
            storeCategories.isNotEmpty &&
            storeCategories.any((category) => categories!.contains(category));

        return notInUserStores && hasCommonCategory;
      }).map((doc) 
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