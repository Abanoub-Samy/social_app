// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = '/editProfile-screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage;
  final picker = ImagePicker();
  File? _coverImage;
  final formKey = GlobalKey<FormState>();
  var nameText = TextEditingController();
  var bioText = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).userModel;
        nameText.text = cubit!.name!;
        bioText.text = cubit.bio!;
        phone.text = cubit.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                    name: nameText.text,
                    phone: phone.text,
                    bio: bioText.text,
                    profileImage: cubit.profileImage,
                    profileCover: cubit.profileCover,
                  );
                },
                child: Text('Update'),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: ConditionalBuilder(
            condition: state is !GetUserLoadingState,
            builder: (context)=>Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        4,
                                      ),
                                      topRight: Radius.circular(
                                        4,
                                      ),
                                    ),
                                    image: DecorationImage(
                                      image: _coverImage == null
                                          ? NetworkImage(
                                        cubit.profileCover.toString(),
                                      )
                                          : FileImage(_coverImage!)
                                      as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 18,
                                    child: Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                  Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  radius: 90,
                                  child: CircleAvatar(
                                    radius: 57,
                                    backgroundImage: _profileImage == null
                                        ? NetworkImage(
                                        cubit.profileImage.toString())
                                        : FileImage(_profileImage!)
                                    as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 15,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_profileImage != null)
                      ElevatedButton(
                        onPressed: () {
                          AppCubit.get(context).uploadProfileImage(_profileImage!);
                          setState(() {
                            _profileImage = null;
                          });
                        },
                        child: Text('Update Profile Image'),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (_coverImage != null)
                      ElevatedButton(
                        onPressed: () {
                          AppCubit.get(context).uploadCoverImage(_coverImage!);
                          setState(() {
                            _coverImage = null;
                          });
                        },
                        child: Text('Update Profile Cover'),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: const Icon(Icons.text_fields),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                controller: nameText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Bio',
                                  prefixIcon: const Icon(Icons.text_snippet),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                controller: bioText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter Bio';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                controller: phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your phone';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _coverImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
