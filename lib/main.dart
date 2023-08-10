import 'package:diabetes_tracker/screens/home.dart';
import 'package:diabetes_tracker/variants/variants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/home_prov.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Variant().configure(VariantTypes.wire);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ],
    child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor:  Colors.green,
          primaryColorLight: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: const OutlineInputBorder()),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all(Colors.lightGreenAccent),
            )
        ),
        home: HomePage(),
      ),
    );
  }
}
