import 'package:diabetes_tracker/providers/authentication.dart';
import 'package:diabetes_tracker/providers/diabetes.dart';
import 'package:diabetes_tracker/screens/add_reading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view_reading_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(onPressed: () => Provider.of<AuthenticationProvider>(context, listen:  false).setUserDetails(context,null), icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddReading())),
              child: const Text('Add Reading'),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DiabetesHistory())),
              child: const Text('View Reading'),
            ),
          ],
        ),
      ),
    );
  }
}