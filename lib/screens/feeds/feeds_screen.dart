import 'package:flutter/material.dart';
import 'package:social_app/screens/feeds/post-item.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getPosts();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).postModel.length > 0 ,
          fallback: (context) => Center(child: Container(child: CircularProgressIndicator())),
          builder: (context) => Container(
            child: Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 20,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd, children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildPostItem(AppCubit.get(context).postModel[index],context,index),
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 10,
                          ),
                      itemCount: AppCubit.get(context).postModel.length ,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

