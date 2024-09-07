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
  List<Store> recommendedStores = [];
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
      DocumentSnapshot documentSnapshot = await firestore.collection(representativeConst)
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

    emit(GetStoresSuccess());

    }catch(e)
    {
      emit(GetStoresFailure(e.toString()));
    }
  }

  Future<void> getRecommendedStores() async
  {
    emit(GetStoresLoading());
    try
    {
      DocumentSnapshot documentSnapshot = await firestore
      .collection(companiesConst)
      .doc(prefs.getString('companyID'))
      .get();

      List? companyCategories = documentSnapshot['categories'];


      List? storesIds = stores.map((doc) => doc.id).toList();

      QuerySnapshot querySnapshot = await firestore
        .collection(storesConst)
        .where('province', isEqualTo: prefs.getString('province'))
        .get();


      recommendedStores = querySnapshot.docs.where((doc) 
      {
        List? storeCategories = doc['categories'];
        String storeId = doc.id;

        bool notInRepresentativeStores = !storesIds.contains(storeId);
        bool hasCommonCategory = storeCategories != null &&
            storeCategories.isNotEmpty &&
            storeCategories.any((category) => companyCategories!.contains(category));

        return notInRepresentativeStores && hasCommonCategory;
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