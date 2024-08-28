import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Providers/scrore_provider.dart';
import 'package:py_quest/Providers/user_provider.dart';
import 'package:py_quest/Screens/UserScreens/dashboard_screen.dart';
import 'package:py_quest/Screens/UserScreens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/device_info.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // final userid = prefs.getString("id");
  // print("user id:" + userid.toString());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DbProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserDetails()),
        ChangeNotifierProvider(create: (_) => ScroreProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: SplashScreen()
        // home: DashboardScreen(),
        home: SignInScreen(),
      ),
    );
  }
}
