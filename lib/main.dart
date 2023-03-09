import 'package:flutter/material.dart';
import 'package:namer_app/pages/appstate.dart';
import 'package:namer_app/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  //each flutter project has a widget method which tells what the widget contains
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          // colorScheme:
          //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 146, 79, 3)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}


