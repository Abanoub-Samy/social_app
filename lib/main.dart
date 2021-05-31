import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/new_post/new_post_screen.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/screens/register_screen.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/cubit/bloc_observer.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isDark = false;
  Widget? widget;
  if(CacheHelper.getData(key: 'isDark') != null){
    isDark = CacheHelper.getData(key: 'isDark');
  }
  if(CacheHelper.getData(key: 'uId') != null){
    uId = CacheHelper.getData(key: 'uId');
    widget = HomeScreen();
  }else {
    widget = LoginScreen();
  }
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext ctx) => AppCubit()..changeAppMode(fromShared: isDark)..getUser(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {

          return MyApp(isDark: isDark,widget: widget,);
        },
      )));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget ;

  MyApp({ required this.isDark,required this.widget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:
      AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: widget,
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        HomeScreen.routeName : (ctx) => HomeScreen(),
        NewPostScreen.routeName : (ctx) => NewPostScreen(),
      },
    );
  }
}
