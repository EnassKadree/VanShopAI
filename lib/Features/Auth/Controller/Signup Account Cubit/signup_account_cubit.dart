import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

part 'signup_account_state.dart';

class SignUpAccountCubit extends Cubit<SignUpAccountState> 
{
  SignUpAccountCubit() : super(SignUpAccountInitial());
  String? selectedCountry;
  String? selectedCompany;
  String? selectedProvince;

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<String> companies = [];
  List<String> countries = [];
  List<String> provinces = [];


  void changeCountry(String country) 
  {
    selectedCountry = country;
    emit(CountryChanged(country));
  }

  void changeProvince(String province) 
  {
    selectedProvince = province;
    emit(ProvinceChanged(province));
  }

  void changeCompany(String company) 
  {
    selectedCompany = company;
    emit(CompanyChanged(company));
  }

  Future<void> getCompanies() async
  {
    emit(GetCompaniesLoading());
    try
    {
      QuerySnapshot querySnapshot = await fireStore.collection(companiesConst).orderBy('trade_name').get();
      companies = querySnapshot.docs.map((snapshot) 
      {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['trade_name'] as String;
      }).toList();
      emit(GetCompaniesSuccess());
    }catch(e)
    {
      emit(GetCompaniesFailure(e.toString()));
    }
  }

  Future<void> getCountries() async
  {
    emit(GetCountriesLoading());
    CollectionReference countriesCollection = fireStore.collection(countriesConst);
    try 
    {
      QuerySnapshot querySnapshot = await countriesCollection.orderBy('country').get();
      countries = querySnapshot.docs.map((snapshot) 
      {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['country'] as String;
      }).toList();
      emit(GetCountriesSuccess());
    } catch (e) 
    {
      emit(GetCountriesFailure('$e'));
    }
  }

  Future<void> getProvinces(String country) async
  {
    emit(GetProvincesLoading());
    try 
    {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
          .collection(countriesConst)
          .where('country', isEqualTo: country)
          .get();

      if (querySnapshot.docs.isNotEmpty) 
      {
        DocumentSnapshot<Map<String, dynamic>> countryDoc = querySnapshot.docs.first;

        provinces = List<String>.from(countryDoc.data()?['provinces'] ?? []);
        provinces.sort((a, b) => a.compareTo(b));

        emit(GetProvincesSuccess());
      } else 
      {
        emit(GetProvincesFailure('Country not found'));
      }
    } catch (e) 
    {
      emit(GetProvincesFailure('$e'));
    }
  }

  createCompanyAccount({required tradeName, required country, required phone}) async
  {
    emit(SignUpAccountLoading());
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null)
    { emit(SignUpAccountFailure('يرجى إنشاء حساب أولاً')); return; }
    else
    {
      if(country == null)
      { emit(SignUpAccountFailure('يرجى تحديد بلد أولاً')); return;}
      try
      {
        await fireStore.collection(companiesConst).doc(user.uid).set
        ({
          'user_id': user.uid,
          'email': user.email,
          'trade_name': tradeName,
          'phone' : phone,
          'country' : country,
          'createdAt': FieldValue.serverTimestamp(),
        });
        emit(SignUpAccountSuccess());
      }catch(e)
      {
        emit(SignUpAccountFailure('حصل خطأ ما، يرجى إعادة المحاولة'));
      }
    }
  }

  createDistributorAccount({required tradeName, required country, required phone, required province}) async
  {
    emit(SignUpAccountLoading());
    User? user = FirebaseAuth.instance.currentUser;

    if(user == null)
    { emit(SignUpAccountFailure('يرجى إنشاء حساب أولاً')); return; }
    else
    {
      if(country == null)
      { emit(SignUpAccountFailure('يرجى تحديد بلد أولاً')); return; }
      if(province == null)
      { emit(SignUpAccountFailure('يرجى تحديد محافظة أولاً')); return; }
      try
      {
        await fireStore.collection(distributorsConst).doc(user.uid).set
        ({
          'user_id': user.uid,
          'email': user.email,
          'trade_name': tradeName,
          'phone' : phone,
          'country' : country,
          'province' : province,
          'createdAt': FieldValue.serverTimestamp(),
          'stores' : [],
          'categories' : []
        }, SetOptions(merge: true));
        emit(SignUpAccountSuccess());
      }catch(e)
      {
        emit(SignUpAccountFailure('حصل خطأ ما، يرجى إعادة المحاولة'));
      }
    }
  }

  createRepresentativeAccount({required tradeName, required country, required phone, required province, required company}) async
  {
    emit(SignUpAccountLoading());
    User? user = FirebaseAuth.instance.currentUser;

    if(user == null)
    { emit(SignUpAccountFailure('يرجى إنشاء حساب أولاً')); return;}
    
    else
    {
      if(company == null)
      { emit(SignUpAccountFailure('يرجى تحديد شركة أولاً')); return;}
      if(country == null)
      { emit(SignUpAccountFailure('يرجى تحديد بلد أولاً')); return;}
      if(province == null)
      { emit(SignUpAccountFailure('يرجى تحديد محافظة أولاً')); return;}
      try
      {
        QuerySnapshot querySnapshot = await fireStore.collection(companiesConst).where('trade_name', isEqualTo: company).get();
        await fireStore.collection(representativeConst).doc(user.uid).set
        ({
          'user_id': user.uid,
          'email': user.email,
          'trade_name': tradeName,
          'phone' : phone,
          'country' : country,
          'province' : province,
          'company_id': querySnapshot.docs.first.id,
          'submitted': false,
          'rejected' : false,
          'createdAt': FieldValue.serverTimestamp(),
          'stores' : [],
        });
        emit(SignUpAccountSuccess());
      }catch(e)
      {
        emit(SignUpAccountFailure('حصل خطأ ما، يرجى إعادة المحاولة'));
      }
    }
  }

  
  createStoreAccount({required tradeName, required country, required phone, required province, required address}) async
  {
    emit(SignUpAccountLoading());
    User? user = FirebaseAuth.instance.currentUser;

    if(user == null)
    { emit(SignUpAccountFailure('يرجى إنشاء حساب أولاً')); return; }
    else
    {
      if(country == null)
      { emit(SignUpAccountFailure('يرجى تحديد بلد أولاً')); return; }
      if(province == null)
      { emit(SignUpAccountFailure('يرجى تحديد محافظة أولاً')); return; }
      try
      {
        await fireStore.collection(storesConst).doc(user.uid).set
        ({
          'user_id': user.uid,
          'email': user.email,
          'trade_name': tradeName,
          'phone' : phone,
          'country' : country,
          'province' : province,
          'address': address,
          'createdAt': FieldValue.serverTimestamp(),
          'categories' : []
        });
        emit(SignUpAccountSuccess());
      }catch(e)
      {
        emit(SignUpAccountFailure('حصل خطأ ما، يرجى إعادة المحاولة'));
      }
    }
  }
}
