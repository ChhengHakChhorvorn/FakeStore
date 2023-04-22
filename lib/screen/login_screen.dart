import 'package:fake_store/data/response/user_response.dart';
import 'package:fake_store/helper/firebase_service.dart';
import 'package:fake_store/helper/widget/custom_snackbar.dart';
import 'package:fake_store/screen/home_screen.dart';
import 'package:fake_store/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/bloc/UserBloc/user_bloc.dart';
import '../helper/style/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200.withOpacity(0.5),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(200),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    left: 210,
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade200.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Text(
                      "Let's Sign you in",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 20,
                    child: Text(
                      "Welcome Back , \nYou have been missed",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fake',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Store',
                    style: TextStyle(
                      color: orange,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: txtEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: txtPassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('Password'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ));
                                if (state is GetUserSuccessState) {
                                  final user = state.users;
                                  if (_formKey.currentState!.validate()) {
                                    for (UserResponse userLogin in user) {
                                      if (userLogin.email == txtEmail.text &&
                                          userLogin.password == txtPassword.text) {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                              user: userLogin,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                    }
                                    try {
                                      final credential =
                                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: txtEmail.text,
                                        password: txtPassword.text,
                                      );
                                      if (credential.user != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        showSnackBar(
                                            context: context, message: 'No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        showSnackBar(
                                            context: context,
                                            message: 'Wrong password provided for that user.');
                                      }
                                    }
                                  }
                                } else {
                                  showSnackBar(context: context, message: 'Login Error');
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          Text(' Or '),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              GoogleSignIn _googleSignIn = GoogleSignIn(
                                scopes: [
                                  'email',
                                  'https://www.googleapis.com/auth/userinfo.email',
                                ],
                              );
                              try {
                                FirebaseService service = FirebaseService();
                                await service.signInwithGoogle();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              } catch (error) {
                                showSnackBar(
                                  context: context,
                                  message: 'Sign Up Error',
                                );
                              }
                            },
                            child: Text('Sign in with Google'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
