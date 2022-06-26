import 'package:flutter/material.dart';

import 'provider.dart';
import 'screens/home.dart';
import 'services/interceptors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initiateInterceptors();
  CoreDataHolder().getLocalData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor:  Colors.blue,
          primaryColorLight: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(132, 70, 113, 1))
      ),
      home: const HomePage(),
    );
  }
}