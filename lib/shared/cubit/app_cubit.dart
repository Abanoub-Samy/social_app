import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;


  int currentIndex = 0;
  // List<Widget> screens = [
  //   ProductsScreen(),
  //   CategoriesScreen(),
  //   FavoritesScreen(),
  //   SettingsScreen(),
  // ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
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

  // LoginModel? loginModel;
  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   DioHelper.postDate(
  //     url: Login,
  //     token: Token,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     loginModel = LoginModel.fromJson(value.data);
  //     //print(loginModel!.data!.email);
  //     emit(LoginSuccessState());
  //   }).catchError((onError) {
  //     emit(LoginErrorState(onError.toString()));
  //     print(onError.toString());
  //   });
  // }

  // RegisterModel? registerModel;
  //
  // void userRegister({
  //   required String name,
  //   required String phone,
  //   required String email,
  //   required String password,
  //   //required String image,
  // }) {
  //   emit(RegisterLoadingState());
  //   DioHelper.postDate(
  //     url: Register,
  //     token: Token,
  //     data: {
  //       'name': name,
  //       'phone': phone,
  //       'email': email,
  //       'password': password,
  //       // 'image': image,
  //     },
  //   ).then((value) {
  //     registerModel = RegisterModel.fromJson(value.data);
  //     //print(loginModel!.data!.email);
  //     emit(RegisterSuccessState());
  //   }).catchError((onError) {
  //     emit(RegisterErrorState(onError.toString()));
  //     print(onError.toString());
  //   });
  // }
  //
}
