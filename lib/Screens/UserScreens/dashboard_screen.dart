import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Screens/ChapterScreens/chapters_screen.dart';
import '../../Resuable widgets/container.dart';
import '../../Resuable widgets/my_drawer.dart';
import '../../Utils/device_info.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetails>(context, listen: false).getUsersDetailsFromPref();
    // print("Hello World");
    return Scaffold(
        drawer: MyDrawer(),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight * 0.32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Colors.pinkAccent, Colors.purpleAccent]),
                  ),
                ),
              ),
              Positioned(
                top:
                    screenHeight * 0.3 + 10, // Position below the red container
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 37, 33, 34),
                  ),
                  height: screenHeight * 0.7,
                ),
              ),
              Positioned(
                top: screenHeight * .25,
                right: 20,
                left: 20,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerCustom(
                            imageUrl: 'assets/subjects/flutter.png',
                            onPressed: () {},
                            textData: 'Flutter',
                          ),
                          ContainerCustom(
                            imageUrl: 'assets/subjects/python.png',
                            textData: 'Python',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChaptersScreen(
                                            name: "Python",
                                          )));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerCustom(
                            imageUrl: 'assets/subjects/java.png',
                            textData: 'Java',
                            onPressed: () {},
                          ),
                          ContainerCustom(
                            imageUrl: 'assets/subjects/js.png',
                            textData: 'JavaScript',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerCustom(
                            imageUrl: 'assets/subjects/mysql.png',
                            textData: 'MySQL',
                            onPressed: () {},
                          ),
                          ContainerCustom(
                            imageUrl: 'assets/subjects/html.png',
                            textData: 'HTML5',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Builder(builder: (context) {
                return Positioned(
                    top: 30,
                    left: 12,
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ));
              }),
              Positioned(
                  top: 70,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<UserDetails>(
                        builder: (context, value, child) {
                          return Text(
                            'Hey, ${value.userName}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      Text(
                        'What would You \nLike to learn today?',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
