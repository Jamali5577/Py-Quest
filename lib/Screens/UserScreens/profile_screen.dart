import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Providers/user_provider.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';
import 'package:py_quest/Utils/device_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    //updateData();
    super.initState();
  }

  // updateData() async {
  //   UserProvider userProvider = Provider.of(context, listen: false);
  //   await userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenHeight * 0.22,
                  width: screenHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Colors.pinkAccent, Colors.purpleAccent]),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 80,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/ACg8ocJXjBtuY7dzx3btQmZQXRKG2zeMiLGQND-VDQrsZ2zA-Tetu0A=s432-c-no'),
                    radius: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Consumer<UserDetails>(
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${value.userName}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${value.email}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: screenHeight / 80,
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Consumer<UserDetails>(
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${value.userName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${value.email}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Score: ${value.points}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(text: 'Edit Profile', ontap: () {}),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
