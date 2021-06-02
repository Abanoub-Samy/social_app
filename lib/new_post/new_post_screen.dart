import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  static String routeName = '/newPost-screen';

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  File? _postsImage;
  final picker = ImagePicker();
  final text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Text(
                    'Post',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onPressed: () {
                    if (_postsImage == null) {
                      AppCubit.get(context).createPost(text: text.text);
                    } else if (_postsImage != null && text.text.isNotEmpty) {
                      AppCubit.get(context).uploadImagePost(
                          text: text.text, postImage: _postsImage);
                    } else if (_postsImage != null && text.text.isEmpty) {
                      AppCubit.get(context)
                          .uploadImagePost(postImage: _postsImage);
                    }
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            cubit.userModel!.profileImage.toString()),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.userModel!.name.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'public',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      maxLines: 20,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'write what you want here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: text,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_postsImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(_postsImage!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _postsImage = null;
                          });
                        },
                        icon: CircleAvatar(radius: 20,child: Icon(Icons.close,size: 16,)),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        getPostsImage();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera),
                          Text('Add Photos'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.people_alt),
                          Text('Tag People'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getPostsImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _postsImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
