import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projects/auth/auth.dart';
import 'package:projects/auth/login_or_register.dart';
import 'package:projects/firebase_options.dart';
import 'package:projects/pages/home_page.dart';
import 'package:projects/pages/profile_page.dart';
import 'package:projects/pages/users_page.dart';
import 'package:projects/theme/dark_mode.dart';
import 'package:projects/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      darkTheme: darkMode(),
      theme: lightMode(),
      routes: {
        '/login_register_page':(context)=> const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}
