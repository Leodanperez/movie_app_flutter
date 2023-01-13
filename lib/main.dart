import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/constants/style.dart';
import 'package:movie_app/screens/home_screen.dart';

Future main() async {
  //load api TMDB api key
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Style.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Style.primaryColor,
        ),
      ),
      home: const HomeScreen()
    );
  }
}
