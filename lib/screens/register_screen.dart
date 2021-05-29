import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/signUp-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;
  final picker = ImagePicker();
  var _formKey = GlobalKey<FormState>();
  var _nameText = TextEditingController();
  var _emailText = TextEditingController();
  var _passwordText = TextEditingController();
  var _confirmPasswordText = TextEditingController();
  var _phoneText = TextEditingController();

  bool _isVisible1 = true;
  bool _isVisible2 = true;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if (state is RegisterSuccessState) {
        //   cubit.userLogin(email: _emailText.text, password: _passwordText.text);
        //   CacheHelper.saveData(
        //     key: 'token',
        //     value: cubit.loginModel!.data!.token.toString(),
        //   ).then((value) {
        //     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        //   });
        //   showToast(
        //       message: cubit.loginModel!.message.toString(),
        //       backgroundColor: Colors.green,
        //       textColor: Colors.white);
        // } else if (state is LoginErrorState) {
        //   showToast(
        //       message: cubit.loginModel!.message.toString(),
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white);
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SignUP Page'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: _image == null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.jpg'),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(_image!),
                                    ),
                              onTap: () {
                                getImage();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon:
                                    const Icon(Icons.text_fields_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              controller: _nameText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter the name';
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
                              controller: _phoneText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter the phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.mail),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              controller: _emailText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter an e-mail';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _isVisible1,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: _isVisible1
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible1 = !_isVisible1;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              controller: _passwordText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter password';
                                } else if (value.length < 8) {
                                  return 'password must be 8 characters at least';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _isVisible2,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon: IconButton(
                                  icon: _isVisible2
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible2 = !_isVisible2;
                                    });
                                  },
                                ),
                              ),
                              controller: _confirmPasswordText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter confirm password';
                                } else if (value.length < 8) {
                                  return 'password must be 8 characters at least';
                                } else if (_confirmPasswordText.text !=
                                    _passwordText.text) {
                                  return 'confirm password must be equal password';
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
                    Container(
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                        builder: (context) => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text('Register'),
                          style: ButtonStyle(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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

// class CustomCircleAvatar extends StatelessWidget {
//   CustomCircleAvatar({required this.backgroundImage, required this.radius});
//
//   final File backgroundImage;
//   final double radius;
//
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 50,
//       backgroundImage: backgroundImage == null
//           ? AssetImage('images/placeperson.png')
//           : FileImage(backgroundImage),
//     );
//   }
// }
