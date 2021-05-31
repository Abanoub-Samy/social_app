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
    if(index == 2)
      emit(NewPostsState());
    else{
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
      profileImage: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.fay3.com%2FiFtqUNEqfoY%2Fdownload&imgrefurl=https%3A%2F%2Fwww.fay3.com%2FiFtqUNEqfoY&tbnid=slr4QpyZtjlhuM&vet=12ahUKEwiao9vv8fPwAhVOaBoKHUIPAcUQMygMegUIARDUAQ..i&docid=aQF4Yv1HIZDMtM&w=1229&h=1280&q=person%20image&ved=2ahUKEwiao9vv8fPwAhVOaBoKHUIPAcUQMygMegUIARDUAQ',
      profileCover: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.fay3.com%2FiFtqUNEqfoY%2Fdownload&imgrefurl=https%3A%2F%2Fwww.fay3.com%2FiFtqUNEqfoY&tbnid=slr4QpyZtjlhuM&vet=12ahUKEwiao9vv8fPwAhVOaBoKHUIPAcUQMygMegUIARDUAQ..i&docid=aQF4Yv1HIZDMtM&w=1229&h=1280&q=person%20image&ved=2ahUKEwiao9vv8fPwAhVOaBoKHUIPAcUQMygMegUIARDUAQ',
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
}
