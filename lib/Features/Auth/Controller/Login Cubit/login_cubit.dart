
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';

import '../../../../Extensions/sharedprefsutils.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> 
{
  LoginCubit() : super(LoginInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late String userType ;
  late Map<String,dynamic> userData ;

  Future<void> singIn({required email, required password, required context}) async
  {
    emit(LoginLoading());
    try
    {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: email,
        password: password
      );
      if (FirebaseAuth.instance.currentUser!.emailVerified) 
      {
        await saveUserToPreferences(credential.user!, context); 
        emit(LoginSuccess(userType: userType, userData: userData)); 
      } else 
      {
        emit(LoginFailure('يرجى تأكيد حسابك الإلكتروني أولاً')); 
      }
    }
    on FirebaseAuthException catch(e)
    {
      if (e.code == 'user-not-found') 
      {
      emit(LoginFailure('هذا المستخدم غير موجود يرجى إنشاء حساب أولاً'));
      } 
      else if (e.code == 'wrong-password') 
      {
        emit(LoginFailure('كلمة سر خاطئة، يرجى إعادة المحاولة'));
      } 
      else
      { emit(LoginFailure('حصل خطأ ما! يرجى إعادة المحاولة')); }
    }
    catch(e)
    {
      emit(LoginFailure('حصل خطأ ما! يرجى إعادة المحاولة'));
    }
  }

  resetPassword(String email, BuildContext context)
  {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then
    ((value) => showSnackBar(context, 'لقد أرسلنا رابطاً لإعادة تعيين كلمة السر إلى بريدك الإلكتروني')).catchError
    ((e) => showSnackBar(context, 'يرجى كتابة بريدك الإلكتروني بشكل صحيح ثم إعادة الطلب'));
  }

  sendVerification(BuildContext context)
  {
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then
    ((value) => showSnackBar(context, 'لقد أرسلنا إلى بريدك الإلكتروني رابطاً لتأكيد الحساب')).
    catchError((e) => showSnackBar(context, 'يرجى محاولة تسجيل الدخول أولاً ثم إعادة الطلب'));
  }

  saveUserToPreferences(User user, BuildContext context) async
  {
    try
    {
      userType = await _getUserType(user.uid);
      userData = await _getUserData(user.uid, userType);

      await prefs.setString('userType', userType);
      await prefs.setString('userID', user.uid);
      await prefs.setString('name', userData['trade_name']);
      await prefs.setString('email', userData['email']);
      await prefs.setString('phone', userData['phone']);
      await prefs.setString('country', userData['country']);

      if(userType == 'Company')
      {
        await prefs.setString('plan', userData['subscription_plan']);
      }
      else if(userType == 'Representative')
      {
        String? company = await getCompanyName(userData);
        await prefs.setString('province', userData['province']);
        await prefs.setString('companyID', userData['company_id']);
        await prefs.setBool('submitted', userData['submitted']);
        await prefs.setString('companyName', company ?? '');
      }
      else if(userType == 'Distributor')
      {
        await prefs.setString('plan', userData['subscription_plan']);
        await prefs.setString('province', userData['province']);
      }
      else if(userType == 'Store')
      {
        await prefs.setString('province', userData['province']);
        await prefs.setString('address', userData['address']);
      }

      navigateRemoveUntil(context, getHomePage(userType));
    }catch(e)
    {
      print('--------------------------------------------------------------');
      print(e);
      emit(LoginFailure(e.toString()));
    }
  }

Future<String> _getUserType(String uid) async 
{
  CollectionReference companies = fireStore.collection('Companies');
  CollectionReference representatives = fireStore.collection('Representatives');
  CollectionReference distributors = fireStore.collection('Distributors');
  CollectionReference stores = fireStore.collection('Stores');

  DocumentSnapshot doc = await companies.doc(uid).get();
  if (doc.exists) return 'Company';

  doc = await representatives.doc(uid).get();
  if (doc.exists) return 'Representative';

  doc = await distributors.doc(uid).get();
  if (doc.exists) return 'Distributor';

  doc = await stores.doc(uid).get();
  if (doc.exists) return 'Store';

  throw Exception("User not found in any collection");
  }

  Future<Map<String, dynamic>> _getUserData(String uid, String userType) async 
  {
    CollectionReference collection = fireStore.collection(userType == 'Company'? 'Companies' : '${userType}s');
    DocumentSnapshot doc = await collection.doc(uid).get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<String?> getCompanyName(doc) async
  {
    try
    {
      DocumentSnapshot documentSnapshot = await fireStore.collection('Companies').doc(doc['company_id']).get();
      return documentSnapshot['trade_name'];
    }catch(e)
    {
      return null;
    }
  }
}
