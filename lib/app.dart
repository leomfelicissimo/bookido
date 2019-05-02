import 'package:bookido/screens/home_screen.dart';
import 'package:bookido/screens/login_screen.dart';
import 'package:bookido/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatelessWidget {
  ThemeData get _themeData => new ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.grey[300],
      textTheme: TextTheme(
          display4: TextStyle(
              fontFamily: 'Corben',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.black)));

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bookido',
      theme: _themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
