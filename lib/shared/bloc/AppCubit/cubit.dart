import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/states.dart';
import '../../../models/chatModel.dart';
import '../../../models/loginModel.dart';
import '../../components/components.dart';
import 'dart:io';

import '../../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  FocusNode? searchUserNode;

  AppCubit(AppStates initialState) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  File? profileImageFile;

  File? messageImageFile;

  bool wannaSearchForUser = false;

  List<LoginModel> allUsers = [];
  ImagePicker picker = ImagePicker();

  List<ChatsModel> messages = [];
  Map<String, dynamic> user = {};

  void wannaSearch(context) {
    wannaSearchForUser = !wannaSearchForUser;
    FocusScope.of(context).requestFocus(searchUserNode);
    emit(AppWannaSearchSuccessState());
  }

  void getGalleryMessageImage() async {
    var pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      messageImageFile = File(pickedFile.path);

      emit(AppGetGalleryImageSuccessState());
    } else {
      pint('No Image selected');
      emit(AppGetGalleryImageErrorState());
    }
  }

  void getCameraMessageImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      messageImageFile = File(pickedFile.path);
      emit(AppGetCameraImageSuccessState());
    } else {
      pint('No Image selected');
      emit(AppGetCameraImageErrorState());
    }
  }

  void undoGetMessageImage() {
    messageImageFile = null;
    emit(AppUndoGetMessageImageSuccessState());
  }

  //********************
  String compressedImagePath = "/storage/emulated/0/Download/";

  Future compressImage({required originalImage}) async {
    if (originalImage == null) return null;
    print('${await originalImage!.length()}' + ' before');
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      originalImage!.path,
      "$compressedImagePath/file1.jpg",
      quality: 10,
    );
    if (compressedFile != null) {
      originalImage = compressedFile;
      print('${await originalImage!.length()}' + ' after');
    }
    emit(AppCIState());
  }

  //********************

  void senMessage({
    required String receiverId,
    required String textMessage,
    String? imageMessage,
    required String messageDateTime,
  }) {
    emit(AppSendMessageLoadingState());
    ChatsModel chatsModel = ChatsModel(
      chatPersonName: loginModel!.name,
      senderId: loginModel!.uId,
      receiverId: receiverId,
      textMessage: textMessage,
      imageMessage: imageMessage ?? '',
      messageDateTime: messageDateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(loginModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatsModel.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((onError) {
      pint(onError.toString());
      emit(AppSendMessageErrorState(onError.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(loginModel!.uId)
        .collection('messages')
        .add(chatsModel.toMap())
        .then((value) {
          undoGetMessageImage();
      emit(AppSendMessageSuccessState());

    }).catchError((onError) {
      pint(onError.toString());
      emit(AppSendMessageErrorState(onError.toString()));
    });
  }

  void sendMessageWithImage({
    required String receiverId,
    required String textMessage,
    required String messageDateTime,
  }) {
    emit(AppSendMessageWithImageLoadingState());
    compressImage(originalImage: messageImageFile);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${loginModel!.uId}/Chats/$receiverId/Messages/${Uri.file(messageImageFile!.path).pathSegments.last}')
        .putFile(messageImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        senMessage(
          receiverId: receiverId,
          textMessage: textMessage,
          messageDateTime: messageDateTime,
          imageMessage: value,
        );
        emit(AppSendMessageSuccessState());
      }).catchError((onError) {
        pint(onError.toString());
        emit(AppSendMessageErrorState(onError.toString()));
      });
    }).catchError((onError) {
      pint(onError.toString());
      emit(AppSendMessageWithImageErrorState(onError.toString()));
    });
  }

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(loginModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageDateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(ChatsModel.fromJson(element.data()));
      }
      emit(AppGetMessageSuccessState());
    });
  }

  void getUserData() {
    emit(AppGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      loginModel = LoginModel.fromJson(value.data()!);
      pint(loginModel!.name.toString());
      emit(AppGetUserDataSuccessState());
    }).catchError((onError) {
      pint(onError.toString());
      emit(AppGetUserDataErrorState(onError.toString()));
    });
  }

  getAllUsers() {
    allUsers.clear();
    emit(AppGetAllUsersDataLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != loginModel!.uId) {
          allUsers.add(LoginModel.fromJson(element.data()));
        }
        emit(AppGetAllUsersDataSuccessState());
      }
    }).catchError((onError) {
      pint(onError.toString());
      emit(AppGetAllUsersDataErrorState(onError.toString()));
    });
  }

  void getGalleryProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);

      emit(AppGetGalleryImageSuccessState());
    } else {
      pint('No Image selected');
      emit(AppGetGalleryImageErrorState());
    }
  }

  void getCameraProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);
      emit(AppGetCameraImageSuccessState());
    } else {
      pint('No Image selected');
      emit(AppGetCameraImageErrorState());
    }
  }
}
