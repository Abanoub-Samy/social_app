import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/screens/register_screen.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/cubit/bloc_observer.dart';
import 'package:social_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isDark = false;
  if(CacheHelper.getData(key: 'isDark') != null){
    isDark = CacheHelper.getData(key: 'isDark');
  }
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext ctx) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {

          return MyApp(isDark: isDark,);
        },
      )));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp({ required this.isDark});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:
      AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
      },
    );
  }
}
