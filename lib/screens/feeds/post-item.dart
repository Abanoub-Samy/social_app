import 'package:flutter/material.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';

Widget buildPostItem(PostModel postModel, BuildContext context , int index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(postModel.profileImage.toString()),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name.toString(),
                            style: TextStyle(
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        postModel.date.toString(),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.2,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.withOpacity(.3),
              ),
            ),
            if (postModel.text != null)
              Text(
                postModel.text.toString(),
                style: TextStyle(
                  height: 1,
                ),
              ),
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        height: 20,
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          '#softDevelopment',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        height: 20,
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (postModel.postImage != null)
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      postModel.postImage.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outline,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${AppCubit.get(context).likes}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${AppCubit.get(context).comments} comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.withOpacity(.5),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(AppCubit.get(context).userModel!.profileImage.toString()),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'write comment ....',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.2,
                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                      AppCubit.get(context).postComment(AppCubit.get(context).postId[index], 'good');
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppCubit.get(context).postLike(AppCubit.get(context).postId[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
