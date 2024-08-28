import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';

import 'package:py_quest/Screens/UserScreens/profile_screen.dart';
import 'package:py_quest/Screens/UserScreens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    //updateData();
    super.initState();
  }

  void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', '');
    prefs.setString('name', '');
    prefs.setString('password', '');
    prefs.setString('id', '');
  }
  // updateData() async {
  //   UserProvider userProvider = Provider.of(context, listen: false);
  //   await userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    //final currentuser = Provider.of<UserDetails>(context, listen: false);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.pinkAccent, Colors.purpleAccent]),
        ),
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 43,
                  foregroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/a/ACg8ocJXjBtuY7dzx3btQmZQXRKG2zeMiLGQND-VDQrsZ2zA-Tetu0A=s432-c-no'),
                ),
                SizedBox(
                  height: 5,
                ),
                Consumer<UserDetails>(
                  builder: (context, value, child) {
                    return Text(
                      '${value.userName}',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    );
                  },
                )
              ],
            )),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                size: 28,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserProfileScreen()));
              },
              leading: Icon(
                CupertinoIcons.person_alt,
                size: 28,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.chart_bar,
                size: 28,
                color: Colors.white,
              ),
              title: Text(
                'Leadership',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                clearPreferences();

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SignInScreen()));
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.square_arrow_left,
                  size: 28,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
