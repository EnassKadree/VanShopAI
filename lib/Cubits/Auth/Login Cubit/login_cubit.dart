// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vanshopai/Helper/snackbar.dart';

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

  resetPassword(String email, BuildContext context)
  {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then
    ((value) => ShowSnackBar(context, 'لقد أرسلنا رابطاً لإعادة تعيين كلمة السر إلى بريدك الإلكتروني')).catchError
    (() => ShowSnackBar(context, 'يرجى كتابة بريدك الإلكتروني بشكل صحيح ثم إعادة الطلب'));
  }

  sendVerification(BuildContext context)
  {
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then
    ((value) => ShowSnackBar(context, 'لقد أرسلنا إلى بريدك الإلكتروني رابطاً لتأكيد الحساب')).
    catchError(() => ShowSnackBar(context, 'يرجى محاولة تسجيل الدخول أولاً ثم إعادة الطلب'));
  }
}
