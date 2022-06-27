import 'dart:async';

import 'package:diabetes_tracker/screens/authentication/login.dart';
import 'package:diabetes_tracker/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/authentication.dart';
import 'providers/diabetes.dart';
import 'services/interceptors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initiateInterceptors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider<DiabetesProvider>(create: (_) => DiabetesProvider()),
    ],
    child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor:  Colors.blue,
          primaryColorLight: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(132, 70, 113, 1)),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: const OutlineInputBorder()),
        ),
        home: UserLoginStatus(),
      ),
    );
  }
}

class UserLoginStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<AuthenticationProvider>(context, listen:  false).getUserDetails(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return RichText(text: TextSpan(text: 'Failed to load the user data'));
                } else {
                  if (snapshot.data != null) return HomePage();
                  else return LoginPage();
                }
            }
          })
    );
  }
}
