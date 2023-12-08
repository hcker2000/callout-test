// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:english_words/english_words.dart';
import 'pages/splash_page.dart';
// import 'pages/one_step_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// final myAppStateProvider = ChangeNotifierProvider((ref) => MyAppState());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Namer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 0, 48, 92),
            brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
