import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softareo_chat/shared/bloc/registerCubit/states.dart';
import '../../../models/loginModel.dart';
import '../../components/components.dart';
import '../../components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(RegisterStates initialState) : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData visible = Icons.visibility;
  bool isShown = true;

  void changePasswordVisibility() {
    isShown = !isShown;
    visible = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(ChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      // var receiverFCMToken = await FirebaseMessaging.instance.getToken();
      createUser(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
    }).catchError((onError) {
      pint(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String email,
    String? uId,
    String? receiverFCMToken,
  }) {
    emit(RegisterLoadingState());
    loginModel = LoginModel(
      name: name,
      phone: phone,
      email: email,
      bio: 'Write your bio',
      uId: uId!,
      receiverFCMToken: receiverFCMToken ?? '',
      profileImage: initialProfImg,
      profileCover: initialProfCover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(loginModel!.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((onError) {
      pint(onError.toString());
      emit(RegisterCreateUserErrorState(onError));
    });
  }
}
