import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Model/Representative.dart';
import 'package:vanshopai/constants.dart';

import '../../../sharedprefsUtils.dart';

part 'representatives_state.dart';

class RepresentativesCubit extends Cubit<RepresentativesState> 
{
  RepresentativesCubit() : super(RepresentativesInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Representative> representatives = [];
  List<Representative> representativesRequests = [];

  Future<void> getRepresentatives() async 
  {
    emit(RepresentativesLoading());
    try 
    {
      QuerySnapshot querySnapshot = await fireStore.collection(representativeConst)
        .where('company_id', isEqualTo: prefs.getString('userID'))
        .get();

      List<Representative> submittedRepresentatives = [];
      List<Representative> nonSubmittedRepresentatives = [];

      for (var doc in querySnapshot.docs) 
      {
        Representative representative = Representative.fromJson
        ({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });

        if (representative.submitted) 
        {  submittedRepresentatives.add(representative); } 
        else 
        { nonSubmittedRepresentatives.add(representative); }
      }

    representativesRequests = nonSubmittedRepresentatives;
    representatives = submittedRepresentatives;

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
      getRepresentatives();
    } catch (e) 
    {
      emit(RepresentativesUpdateFailure(e.toString()));
    }
  }
}
