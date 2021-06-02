import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user-model.dart';
import 'package:social_app/new_post/new_post_screen.dart';
import 'package:social_app/screens/chats/chats_screen.dart';
import 'package:social_app/screens/feeds/feeds_screen.dart';
import 'package:social_app/screens/settings/settings_screen.dart';
import 'package:social_app/screens/users/users_screen.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  int currentIndex = 0;
  var fireStore = FirebaseFirestore.instance;
  var fireAuth = FirebaseAuth.instance;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'News Feeds',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottom(int index) {
    if (index == 2)
      emit(NewPostsState());
    else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeMode());
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    fireAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) {
    emit(RegisterLoadingState());
    fireAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.uid.toString());
      createUser(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
      // emit(RegisterSuccessState());
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio: 'write your bio ...',
      profileImage:
          'hWX_4UKHendA94QMygFegUIARDCAQ..i&docid=4KNx8nObko9xRM&w=1200&h=1200&q=images%20oerson&ved=2ahUKEwjyvYDCy_',
      profileCover:
          'hWX_4UKHendA94QMygFegUIARDCAQ..i&docid=4KNx8nObko9xRM&w=1200&h=1200&q=images%20oerson&ved=2ahUKEwjyvYDCy_',
    );
    fireStore.collection('users').doc(uId).set(userModel.toMap()).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  UserModel? userModel;

  void getUser() {
    emit(GetUserLoadingState());
    fireStore.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserErrorState(onError.toString()));
    });
  }


  void uploadProfileImage(File profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel!.name!,
          phone: userModel!.phone!,
          bio: userModel!.bio!,
          profileCover: userModel!.profileCover!,
          profileImage: value,
        );
        getUser();
      }).catchError((onError) {});
    }).catchError((onError) {
      print(onError.toString());
    });
  }


  void uploadCoverImage(File coverImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel!.name!,
          phone: userModel!.phone!,
          bio: userModel!.bio!,
          profileCover: value,
          profileImage: userModel!.profileImage!,
        );
        getUser();
      }).catchError((onError) {});
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // void updateUserIf({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   File? profileImage,
  //   File? profileCover,
  // }) {
  //    if (profileImage != null) {
  //     uploadCoverImage(profileImage);
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //       profileImage: profileImageUrl,
  //     );
  //   } else if (profileCover != null) {
  //     uploadCoverImage(profileCover);
  //
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? profileCover,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      isEmailVerified: false,
      bio: bio,
      profileImage: profileImage,
      profileCover: profileCover,
      );
    fireStore
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUser();
      emit(UpdateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateUserErrorState(onError.toString()));
    });
  }
}
