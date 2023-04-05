import 'package:Nouns_app/models/social_app/social_user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Regester_states.dart';

class SocialRegisterCubit extends Cubit <SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password)

        .then((value) {
          userCreate(
            uId: value.user!.uid,
            phone: phone,
            email: email,
            name: name,
            password: password,
          );
    }).catchError((error)
     {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String password,
}) {
  SocialUserModel model = SocialUserModel(
    name: name,
    email: email,
    image:  'https://media.istockphoto.com/id/610003972/vector/vector-businessman-black-silhouette-isolated.jpg?s=2048x2048&w=is&k=20&c=Pn251mZr8zL1rs67NLf61FKVIIyOOClvQCgOtGpahMQ=',
    bio: 'write your bio...',
    cover:  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1676309415~exp=1676310015~hmac=89df74dae2a01dd034423016651a6e881f226897b04e4e3850003907dbf5418d',
    phone: phone,
    uId: uId,
    isEmailVerified: false,
    password: password,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap())
      .then((value)
  {
        emit(SocialCreateUserSuccessState());
  })
      .catchError((error) {
    print(error.toString());
    emit(SocialRegisterErrorState(error.toString()));
  });

}

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined :Icons.remove_red_eye_rounded;
    emit( SocialRegisterChangePasswordVisibilityState());
  }
}