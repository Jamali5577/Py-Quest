import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Resuable%20widgets/alert_dialog.dart';
import 'package:py_quest/Screens/UserScreens/dashboard_screen.dart';
import 'package:py_quest/Screens/UserScreens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Resuable widgets/custom_btn.dart';
import '../../Resuable widgets/custom_textfield.dart';
import '../../Utils/device_info.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  Future<void> getUserData(String userId) async {
    final databaseRef = await FirebaseDatabase.instance.ref('Users');
    await databaseRef.child(userId).once().then((val) {
      Provider.of<UserDetails>(context, listen: false)
          .setUsersDetails(val.snapshot);

      //Provider.of<UserDetails>(context).setUserPreferences();

      // print("Username :  " +
      //   Provider.of<UserDetails>(context, listen: false).userName.toString());
      // print("password :  " +
      // Provider.of<UserDetails>(context, listen: false).password.toString());
    });
  }

  bool isLogined = false;
  checkIfLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final uid = pref.getString("id");
    if (uid != "") {
      setState(() {
        isLogined = true;
        Provider.of<UserDetails>(context, listen: false)
            .getUsersDetailsFromPref();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DashboardScreen()));
      });
    }
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Colors.pinkAccent, Colors.purpleAccent]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: screenWidth / 1.7,
                  height: screenHeight / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Column(
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.only(right: 16, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgat Password?',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blueAccent),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CustomButton(
                              text: 'Login',
                              ontap: () {
                                // loginUser();
                                userLogin(_emailController.text,
                                    _passController.text);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You don't have an Account?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignUpScreen()));
                                },
                                child: Text(
                                  'Sign Up',
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
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Form(
                  child: Row(
                    children: [
                      Image(
                          height: 150,
                          width: screenHeight / 6,
                          image: AssetImage('assets/jogging.png')),
                      Column(
                        children: [
                          Text(
                            'Login to Play',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void userLogin(String email, String password) async {
    if (email == '' || password == '') {
      UiHelper.CustomAlertBox(context, 'Enter Required Fields');
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((val) async {
          if (val.user!.uid != "") {
            print("Login Id = " + val.user!.uid.toString());
            await Future.value(getUserData(val.user!.uid.toString()));

            return Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => DashboardScreen()));
          }
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
