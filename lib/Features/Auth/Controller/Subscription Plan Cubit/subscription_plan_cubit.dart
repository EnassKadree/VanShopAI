import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

part 'subscription_plan_state.dart';

class PlanCubit extends Cubit<PlanState> 
{
  PlanCubit() : super(PlanInitial());
  String? selectedCompanyPlan; 
  String? selectedDistributorPlan; 
  List<String> companies = 
  [
    'مجاناً لمدة شهر',
    'اشتراك سنوي لأقل من 10 مندوبين 200\$ سنوياً',
    'اشتراك سنوي بين 10 و 25 مندوباً 400\$ سنوياً',
    'اشتراك سنوي لأكثر من 25 مندوباً 600\$ سنوياً',
  ];

  List<String> distributors = 
  [
    'مجاناً لمدة شهر',
    'اشتراك سنوي 150\$'
  ];

  void changeCompanyPlan(String plan) 
  {
    selectedCompanyPlan = plan;
    emit(CompanyPlanChanged(plan));
  }

  void changeDistributorPlan(String plan) 
  {
    selectedDistributorPlan = plan;
    emit(DistributorPlanChanged(plan));
  }

  Future<void> saveUserPlan(String type) async 
  {
    emit(SavePlanLoading());
    try 
    {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) 
      {
        emit(SavePlanFailure('سجل دخول ثم حاول مرة أخرى'));
        return;
      }

    if(type == companiesConst)
    {
      await FirebaseFirestore.instance.collection(type).doc(user.uid).update
      ({
        'subscription_plan': companyPlan(),
        'number_of_representatives': representativesNumber(),
      });
    }
    else
    {
      await FirebaseFirestore.instance.collection(type).doc(user.uid).update
      ({
        'subscription_plan': distributorPlan(),
      });
    }
      emit(SavePlanSuccess());
    } catch (e) 
    {
      emit(SavePlanFailure(e.toString()));
    }
  }

  representativesNumber()
  {
    if(selectedCompanyPlan == 'اشتراك سنوي لأقل من 10 مندوبين 200\$ سنوياً')
    { return 'أقل من 10'; }
    if(selectedCompanyPlan == 'اشتراك سنوي بين 10 و 25 مندوباً 400\$ سنوياً')
    { return 'بين 10 و 25'; }
    else
    { return 'أكثر من 25';}
  }
  companyPlan()
  {
    if(selectedCompanyPlan == 'مجاناً لمدة شهر')
    { return 'شهر مجاني'; }
    if(selectedCompanyPlan == 'اشتراك سنوي لأقل من 10 مندوبين 200\$ سنوياً')
    { return '200\$'; }
    if(selectedCompanyPlan == 'اشتراك سنوي بين 10 و 25 مندوباً 400\$ سنوياً')
    { return '400\$'; }
    else
    { return '600\$';}
  }
  distributorPlan()
  {
    if(selectedCompanyPlan == 'مجاناً لمدة شهر')
    { return 'شهر مجاني'; }
    else
    { return '150\$'; }
  }
}
