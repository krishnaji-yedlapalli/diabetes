import 'dart:async';

import 'package:diabetes_tracker/models/reading.dart';
import 'package:diabetes_tracker/utils/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/diabetes.dart';

class DiabetesHistory extends StatefulWidget {
  const DiabetesHistory({Key? key}) : super(key: key);

  @override
  State<DiabetesHistory> createState() => _DiabetesHistoryState();
}

class _DiabetesHistoryState extends State<DiabetesHistory> {

  @override
  void initState() {
    Provider.of<DiabetesProvider>(context, listen: false)
        ..readingStreamController = StreamController.broadcast()
        ..fetchReading(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes history reading'),
      ),
      body: StreamBuilder<List<Reading>>(
          stream: Provider.of<DiabetesProvider>(context, listen: false).readingStreamController.stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
                return _buildReadingList(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error while fetching data'));
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                default:
                  return Container();
              }
            }
          })
    );
  }

  Widget _buildReadingList(List<Reading> readingList){
    return readingList.isEmpty ?
        Center(child: Text("Currently you don't have any readings", style: TextStyle(fontWeight: FontWeight.bold),))
    : ListView.builder(
        itemCount: readingList.length,
        itemBuilder: (_, index) => _buildReading(readingList[index]));
  }

  Widget _buildReading(Reading reading) {
      var diabetesProvider = Provider.of<DiabetesProvider>(context, listen: false);
      var style = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
      return ListTile(
        title: Text(reading.mealType == 'beforeMeals' ? 'Before Meals (Fasting)' : 'After Meals',  style: style),
        subtitle: Text('${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(reading.dateTime))}', style: style),
        isThreeLine: true,
        leading:  Text('${reading.reading} \n mg/dl',  style: style),
        trailing: Text('${diabetesProvider.getDiagnosis(reading)}',  style: style),
        tileColor: Colors.black12,
      );
    }
}
