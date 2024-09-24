import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Model/representative.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../../../../Extensions/sharedprefsutils.dart';

part 'representatives_state.dart';

class RepresentativesCubit extends Cubit<RepresentativesState> 
{
  RepresentativesCubit() : super(RepresentativesInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Representative> representatives = [];
  List<Representative> representativesRequests = [];
 
  Future<void> getRepresentatives({required submitted}) async 
  {
    emit(RepresentativesLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(representativeConst)
        .where('company_id', isEqualTo: prefs.getString('userID'))
        .where('submitted', isEqualTo: submitted)
        .where('rejected', isEqualTo: false)
        .get();

        if(submitted)
        {
          representatives = querySnapshot.docs.map((doc) 
          {
            return Representative.fromJson
            ({
              ...doc.data() as Map<String, dynamic>, 
              'id': doc.id, 
            });
          }).toList();
        }

        else
        {
          representativesRequests = querySnapshot.docs.map((doc) 
          {
            return Representative.fromJson
            ({
              ...doc.data() as Map<String, dynamic>, 
              'id': doc.id, 
            });
          }).toList();
        }

      emit(RepresentativesSuccess());
    } catch (e) 
    {
      emit(RepresentativesFailure(e.toString()));
    }
  }

  Future<void> updateRepresentativeSubmitted(String representativeId) async 
  {
    try 
    {
      DocumentReference representativeDoc = fireStore.collection(representativeConst).doc(representativeId);

      await representativeDoc.update({'submitted': true});

      emit(RepresentativesUpdateSuccess());
      getRepresentatives(submitted: false);
    } catch (e) 
    {
      emit(RepresentativesUpdateFailure(e.toString()));
    }
  }

  Future<void> updateRepresentativeRejected(String representativeId) async 
  {
    try 
    {
      DocumentReference representativeDoc = fireStore.collection(representativeConst).doc(representativeId);

      await representativeDoc.update({'rejected': true});

      emit(RepresentativesUpdateSuccess());
      getRepresentatives(submitted: false); 
    } catch (e) 
    {
      emit(RepresentativesUpdateFailure(e.toString()));
    }
  }
}
