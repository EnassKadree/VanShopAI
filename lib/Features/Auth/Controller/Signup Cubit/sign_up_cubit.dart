import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> 
{
  SignUpCubit() : super(SignUpInitial());

  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  Future<void> createAccount({required email, required String password}) async
  {
    emit(SignUpLoading());
    try
    {
      // ignore: unused_local_variable
      UserCredential userCredential = await fireAuth.createUserWithEmailAndPassword
      (
        email: email,
        password: password,
      );

      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(SignUpSuccess());
    }on FirebaseAuthException catch(e)
    {
      if(e.code == 'weak-password')
      { emit(SignUpFailure('كلمة السر ضعيفة جداً حاول تجربة كلمة سر أقوى')); }
      else if(e.code == 'email-already-in-use')
      { emit(SignUpFailure('هذا الحساب موجود بالفعل! إن كنت تمتلك حساباً قم بتسجيل الدخول')); }
      else
      { emit(SignUpFailure('حدث خطأ ما! يرجى المحاولة مرة أخرى')); }
    }
  }
}
