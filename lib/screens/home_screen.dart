import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:social_app/widgets/flutter_toast.dart';

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
              condition: cubit.userModel != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => Column(
                children: [
                  if (!cubit.fireAuth.currentUser!.emailVerified)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 10,
                            ),
                            Text('please verify your email  '),
                            SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.fireAuth.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {
                                    successToast(message: 'check your mail');
                                  }).catchError((onError) {
                                    print(onError.toString());
                                  });
                                },
                                child: Text('SEND'))
                          ],
                        ),
                      ),
                    ),
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
        listener: (ctx, state) {});
  }
}
