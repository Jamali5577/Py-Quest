import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/alert_dialog.dart';
import 'package:py_quest/Screens/UserScreens/sign_in_screen.dart';

import '../../Resuable widgets/custom_btn.dart';
import '../../Resuable widgets/custom_textfield.dart';
import '../../Utils/device_info.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Future<void> addUsers(String name, String email, String password) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc()
        .set({'name': name, 'email': email, 'password': password});
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }

//firebase authentication
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //final dbProvider = Provider.of<DbProvider>(context, listen: false);
    // void registerUser() async {
    //   String resp = await AuthMethods().registerUser(
    //       email: _emailController.text,
    //       password: _passController.text,
    //       name: _nameController.text);

    //   if (resp == 'success') {
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => SignInScreen()));
    //   }
    // }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight / 2.8),
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20),
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                    //color: Color.fromARGB(220, 0, 0, 0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Colors.pinkAccent, Colors.purpleAccent]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: screenWidth / 1.7,
                  height: screenHeight / 2,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 12, right: 12),
                            child: MyWidget(
                                controller1: _nameController,
                                icon: Icons.person,
                                lable: 'Enter Full Name',
                                ispass: false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 12, right: 12),
                            child: MyWidget(
                                controller1: _emailController,
                                icon: Icons.email,
                                lable: 'Enter Email',
                                ispass: false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 12, right: 12),
                            child: MyWidget(
                                controller1: _passController,
                                icon: Icons.lock,
                                lable: 'Enter Password',
                                ispass: true),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CustomButton(
                                text: 'Sign Up',
                                ontap: () {
                                  auth
                                      .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passController.text)
                                      .then((value) {
                                    String uid = value.user!.uid.toString();
                                    //print("New UserId:" + uid);
                                    Provider.of<DbProvider>(context,
                                            listen: false)
                                        .addUser(
                                            uid,
                                            _nameController.text,
                                            _emailController.text,
                                            _passController.text)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  });
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You already have an Account?",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignInScreen()));
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Image(
                            width: 150,
                            height: 150,
                            image: AssetImage(
                              'assets/game.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent),
                            ),
                            Text(
                              'PyQuest',
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            )
                          ],
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
    );
  }

  void SignUp(String email, String password) async {
    if (email == '' || password == '') {
      UiHelper.CustomAlertBox(context, 'Enter Required Feilds');
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Provider.of<DbProvider>(context, listen: false).addUser(
              value.user!.uid.toString(),
              _nameController.text,
              _emailController.text,
              _passController.text);

          UiHelper.CustomAlertBox(context, 'User Created Successfully');
        }).onError(
          (error, stackTrace) {
            UiHelper.CustomAlertBox(context, error.toString());
          },
        );
      } catch (e) {
        UiHelper.CustomAlertBox(context, e.toString());
      }
    }
  }
}
