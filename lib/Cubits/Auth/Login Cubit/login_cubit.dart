import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> 
{
  LoginCubit() : super(LoginInitial());

  Future<void> singIn({required email, required password}) async
  {
    emit(LoginLoading());
    try
    {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: email,
        password: password
      );
      if (FirebaseAuth.instance.currentUser!.emailVerified) 
      {
        emit(LoginSuccess()); 
      } else 
      {
        emit(LoginFailure('يرجى تأكيد حسابك الإلكتروني أولاً')); 
      }
    }
    on FirebaseAuthException catch(e)
    {
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print(e.toString());
      if (e.code == 'user-not-found') 
      {
      emit(LoginFailure('هذا المستخدم غير موجود يرجى إنشاء حساب أولاً'));
      } 
      else if (e.code == 'wrong-password') 
      {
        emit(LoginFailure('كلمة سر خاطئة، يرجى إعادى المحاولة'));
      } 
      else
      { emit(LoginFailure('حصل خطأ ما! يرجى إعادة المحاولة')); }
    }
    catch(e)
    {
      print('===============================================');
      print(e.toString());
    }
  }
}
