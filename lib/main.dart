import 'package:flutter/material.dart';
import 'package:modul_3/views/authentication/login_pages.dart';
import 'package:modul_3/views/list/anime_list.dart';
import 'package:modul_3/views/shared_pref/shared_pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SharedPref(),
    );
  }
}
