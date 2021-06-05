import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/new_post/new_post_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
class HomeScreen extends StatelessWidget {
  static String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (ctx, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active_sharp),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: AppCubit.get(context).postModel.length > 0,
              fallback: (context) => Center(child: CircularProgressIndicator(),),
              builder: (context) => Column(
                children: [
                  cubit.screens[cubit.currentIndex],
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.upload_rounded),
                  label: 'New Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
        listener: (ctx, state) {
          if(state is NewPostsState){
            Navigator.pushNamed(context, NewPostScreen.routeName);
          }
        });
  }
}
