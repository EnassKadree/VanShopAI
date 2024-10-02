import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Core/Model/representative.dart';
import '../../../../Extensions/sharedprefsutils.dart';
import '../../../Core/Model/distributor.dart';
part 'store_dists_state.dart';

class StoreDistsCubit extends Cubit<StoreDistsState> 
{
  StoreDistsCubit() : super(StoreDistsInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Representative> representatives = [];
  List<Distributor> distributors = [];
  List<String> companyNames = [];

  Future<void> getDists() async
  {
    try
    {
      emit(StoreDistsLoading());
      String storeId = prefs.getString('userID')!;

      QuerySnapshot repsSnapshot = await fireStore
        .collection(representativeConst)
        .where('stores', arrayContains: storeId)
        .get();

      QuerySnapshot distsSnapshot = await fireStore
        .collection(distributorsConst)
        .where('stores', arrayContains: storeId)
        .get();

      representatives = repsSnapshot.docs.map((doc) 
      {
        return Representative.fromJson
        ({
          ...doc.data() as Map<String, dynamic>, 
          'id': doc.id, 
        });
      }).toList();

      await getCompaniesNames();

      distributors = distsSnapshot.docs.map((doc) 
      {
        return Distributor.fromJson
        ({
          ...doc.data() as Map<String, dynamic>, 
          'id': doc.id, 
        });
      }).toList();

      emit(StoreDistsSuccess());
    }catch(e)
    { emit(StoreDistsFailure(e.toString()));}
  }


  Future<void> getCompaniesNames() async
  {
    for (Representative rep in representatives) 
    {
      String companyId = rep.companyId;

      DocumentSnapshot companyDoc = await fireStore.collection(companiesConst).doc(companyId).get();

      if (companyDoc.exists) 
      {
        companyNames.add(companyDoc['trade_name'] as String);
      } else
      {
        companyNames.add("Unknown Company");
      }
    }
  }
}
